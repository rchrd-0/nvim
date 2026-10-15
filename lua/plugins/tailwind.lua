local diagnostic_ticks = {}

local function canonical_diagnostics(client, bufnr)
  local namespace = vim.lsp.diagnostic.get_namespace(client.id)
  return vim.lsp.diagnostic.from(vim.tbl_filter(function(diagnostic)
    return diagnostic.code == "suggestCanonicalClasses"
  end, vim.diagnostic.get(bufnr, { namespace = namespace })))
end

local function fix_canonical_classes(bufnr)
  local client = vim.lsp.get_clients({ bufnr = bufnr, name = "tailwindcss" })[1]
  if not client or diagnostic_ticks[bufnr] == nil then
    return
  end

  local uri = vim.uri_from_bufnr(bufnr)
  local changedtick = vim.api.nvim_buf_get_changedtick(bufnr)
  local function request_actions()
    local last_line = vim.api.nvim_buf_line_count(bufnr) - 1
    local text = vim.api.nvim_buf_get_lines(bufnr, last_line, last_line + 1, false)[1]
    return client:request_sync("textDocument/codeAction", {
      textDocument = { uri = uri },
      range = {
        start = { line = 0, character = 0 },
        ["end"] = { line = last_line, character = vim.str_utfindex(text, client.offset_encoding) },
      },
      context = {
        only = { "quickfix" },
        diagnostics = canonical_diagnostics(client, bufnr),
      },
    }, 3000, bufnr)
  end

  -- The request flushes pending document changes. Tailwind debounces diagnostics
  -- by 500 ms, so allow their ranges to catch up when saving immediately after typing.
  local response = request_actions()
  if response and not response.err and diagnostic_ticks[bufnr] ~= changedtick then
    local ready = vim.wait(1000, function()
      return diagnostic_ticks[bufnr] == changedtick
    end, 10)
    if not ready then
      vim.notify("Tailwind canonical fixes skipped: diagnostics are not ready", vim.log.levels.WARN)
      return
    end
    response = request_actions()
  end

  if not response then
    vim.notify("Tailwind canonical fixes timed out", vim.log.levels.WARN)
    return
  elseif response.err then
    vim.notify("Tailwind canonical fixes failed: " .. response.err.message, vim.log.levels.WARN)
    return
  end

  -- Another edit invalidates all ranges returned for the captured document.
  if vim.api.nvim_buf_get_changedtick(bufnr) ~= changedtick then
    return
  end

  local edits = {}
  local seen = {}
  for _, action in ipairs(type(response.result) == "table" and response.result or {}) do
    if not action.disabled and action.kind == "quickfix" and action.diagnostics and #action.diagnostics > 0 then
      local canonical = true
      for _, diagnostic in ipairs(action.diagnostics) do
        if diagnostic.code ~= "suggestCanonicalClasses" then
          canonical = false
          break
        end
      end
      if canonical then
        for _, edit in ipairs(vim.tbl_get(action, "edit", "changes", uri) or {}) do
          local key = vim.json.encode(edit)
          if not seen[key] then
            seen[key] = true
            edits[#edits + 1] = edit
          end
        end
      end
    end
  end

  -- All actions refer to the same document version. Apply them together so
  -- earlier replacements cannot shift the ranges of later classes.
  if #edits > 0 then
    vim.lsp.util.apply_text_edits(edits, bufnr, client.offset_encoding)
  end
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      local server = opts.servers.tailwindcss
      if not server or server.enabled == false then
        return
      end
      server.handlers = server.handlers or {}
      local publish = server.handlers["textDocument/publishDiagnostics"] or vim.lsp.diagnostic.on_publish_diagnostics
      server.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
        if not err and result then
          local bufnr = vim.uri_to_bufnr(result.uri)
          diagnostic_ticks[bufnr] = vim.api.nvim_buf_get_changedtick(bufnr)
        end
        return publish(err, result, ctx, config)
      end

      LazyVim.format.register({
        name = "Tailwind canonical classes",
        primary = false,
        priority = 300, -- Apply semantic class changes before ESLint and Oxfmt formatting.
        sources = function(bufnr)
          -- A client can attach before it discovers a Tailwind project.
          if diagnostic_ticks[bufnr] == nil then
            return {}
          end
          return vim.tbl_map(function(client)
            return client.name
          end, vim.lsp.get_clients({ bufnr = bufnr, name = "tailwindcss", method = "textDocument/codeAction" }))
        end,
        format = fix_canonical_classes,
      })
    end,
  },
}
