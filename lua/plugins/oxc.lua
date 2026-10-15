local standalone_configs = {
  lint = { ".oxlintrc.json", ".oxlintrc.jsonc", "oxlint.config.ts" },
  fmt = { ".oxfmtrc.json", ".oxfmtrc.jsonc", "oxfmt.config.ts" },
}
local vite_configs = { "vite.config.ts", "vite.config.js", "vite.config.mts", "vite.config.mjs" }

local function find_config(directory, field)
  return vim.fs.find(function(name, path)
    if vim.tbl_contains(standalone_configs[field], name) then
      return true
    end
    if not vim.tbl_contains(vite_configs, name) then
      return false
    end
    local contents = table.concat(vim.fn.readfile(vim.fs.joinpath(path, name)), "\n")
    return contents:find("vite%-plus") ~= nil and contents:find(field .. "%s*:") ~= nil
  end, { path = directory, upward = true, type = "file" })[1]
end

local function project_command(name, directory)
  local modules =
    vim.fs.find("node_modules", { path = directory, upward = true, type = "directory", limit = math.huge })
  for _, path in ipairs(modules) do
    local command = vim.fs.joinpath(path, ".bin", name)
    if vim.fn.executable(command) == 1 then
      return command
    end
  end
  return name
end

local function server_options(name, field)
  return {
    enabled = true,
    mason = false,
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
      local file = vim.api.nvim_buf_get_name(bufnr)
      local config = find_config(vim.fs.dirname(file), field)
      if config then
        on_dir(vim.fs.dirname(config))
      end
    end,
    cmd = function(dispatchers, config)
      local path = assert(find_config(config.root_dir, field), name .. " config not found")
      local vite_plus = vim.startswith(vim.fs.basename(path), "vite.config.")
      local command = project_command(vite_plus and "vp" or name, config.root_dir)
      local args = vite_plus and { command, field, "--lsp" } or { command, "--lsp" }
      return vim.lsp.rpc.start(args, dispatchers, { cwd = config.root_dir })
    end,
    before_init = function(params, config)
      local key = field == "fmt" and "fmt.configPath" or "configPath"
      local settings = vim.deepcopy(config.settings or {})
      settings[key] = assert(find_config(config.root_dir, field), name .. " config not found")
      params.initializationOptions = vim.tbl_deep_extend("force", params.initializationOptions or {}, {
        settings = settings,
      })
    end,
  }
end

local function fix_oxlint_on_save(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = "oxlint" })[1]
  if not client then
    return
  end

  local response = client:request_sync("workspace/executeCommand", {
    command = "oxc.fixAll",
    arguments = { { uri = vim.uri_from_bufnr(bufnr) } },
  }, 5000, bufnr)

  if not response then
    vim.notify("Oxlint fix on save timed out", vim.log.levels.WARN)
  elseif response.err then
    vim.notify("Oxlint fix on save failed: " .. response.err.message, vim.log.levels.WARN)
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("oxlint_fix_on_save", { clear = true }),
  callback = function(args)
    fix_oxlint_on_save(args.buf)
  end,
})

local oxlint = server_options("oxlint", "lint")
oxlint.settings = { run = "onType", fixKind = "safe_fix", typeAware = true }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        oxlint = oxlint,
        oxfmt = server_options("oxfmt", "fmt"),
      },
      setup = {
        oxfmt = function()
          -- Prefer this LSP over Conform's CLI formatters only where it is attached.
          LazyVim.format.register(LazyVim.lsp.formatter({
            name = "Oxfmt LSP",
            filter = "oxfmt",
            priority = 200,
            format = function(bufnr)
              -- Build formatting parameters in the target buffer, including hidden-buffer saves.
              vim.api.nvim_buf_call(bufnr, function()
                vim.lsp.buf.format({ bufnr = bufnr, name = "oxfmt", timeout_ms = 3000 })
              end)
            end,
          }))
        end,
      },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "oxlint", "oxfmt" } },
  },
}
