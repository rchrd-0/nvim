return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
    {
      '<leader>uf',
      function()
        vim.g.disable_autoformat = not vim.g.disable_autoformat
        print('Global autoformatting ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
      end,
      mode = 'n',
      desc = 'Toggle Auto Format (Global)',
    },
    {
      '<leader>uF',
      function()
        vim.b.disable_autoformat = not vim.b.disable_autoformat
        print('Buffer autoformatting ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
      end,
      mode = 'n',
      desc = 'Toggle Auto Format (Buffer)',
    },
  },
  config = function(_, opts)
    local function is_biome_available()
      local has_biome_config = vim.fn.filereadable(vim.fn.getcwd() .. '/biome.json') == 1

      local has_biome_installed = vim.fn.isdirectory(vim.fn.getcwd() .. '/node_modules/@biomejs') == 1

      return has_biome_config or has_biome_installed
    end

    local biome_prettierd = { 'biome-check', 'prettierd', stop_after_first = true }
    local biome_filetypes = {
      'css',
      'javascript',
      'typescript',
      'javascriptreact',
      'typescriptreact',
    }

    for _, ft in ipairs(biome_filetypes) do
      opts.formatters_by_ft[ft] = biome_prettierd
    end

    local js_ts_filetypes = { 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }
    for _, ft in ipairs(js_ts_filetypes) do
      if opts.formatters_by_ft[ft] then
        local original_formatters = opts.formatters_by_ft[ft]
        opts.formatters_by_ft[ft] = function()
          if is_biome_available() then
            return original_formatters
          else
            return { 'prettierd', stop_after_first = true }
          end
        end
      end
    end

    require('conform').setup(opts)
  end,
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local disable_filetypes = { c = true, cpp = true }
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      swift = { 'swiftformat' },
      html = {
        'prettierd',
      },
      -- css = { 'biome-check', 'prettierd', stop_after_first = true },
      -- javascript = { 'biome-check', 'prettierd', stop_after_first = true },
      -- typescript = { 'biome-check', 'prettierd', stop_after_first = true },
      -- javascriptreact = { 'biome-check', 'prettierd', stop_after_first = true },
      -- typescriptreact = { 'biome-check', 'prettierd', stop_after_first = true },
      json = { 'biome-check', 'jsonls', stop_after_first = true },
      vue = { 'prettierd', stop_after_first = true },
      astro = { 'prettierd', stop_after_first = true },
      sql = { 'sqlfmt' },
      http = { 'kulala' },
    },
    formatters = {
      ['biome-check'] = {
        command = 'biome',
        -- args = { 'check', '--write', '--organize-imports-enabled=false', '--stdin-file-path', '$FILENAME' },
        args = { 'check', '--write', '--stdin-file-path', '$FILENAME' },
      },
      prettierd = {
        env = {
          PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.config/nvim/.prettierrc.json',
        },
      },
      kulala = {
        command = 'kulala-fmt',
        args = {
          'format',
          '$FILENAME',
        },
        stdin = false,
      },
    },
  },
}
