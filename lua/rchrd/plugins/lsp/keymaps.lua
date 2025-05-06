local M = {}

--- Sets up LSP keymaps for the given buffer.
--- @param bufnr integer The buffer number to set keymaps for.
function M.setup_lsp_keymaps(bufnr)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = 'LSP: ' .. desc })
  end

  -- map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('<leader>ca', vim.lsp.buf.code_action, 'Code [A]ction', { 'n', 'x' })
  map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('gd', vim.lsp.buf.definition, 'LSP: [G]oto [D]efinition')
  map('<C-w>gd', ':vsplit | lua vim.lsp.buf.definition()<CR>', 'LSP: [G]oto [D]efinition in split')

  -- map('grr', fzf.lsp_references, '[G]oto [R]eferences')
  -- map('gri', fzf.lsp_implementations, '[G]oto [I]mplementation')
  -- map('grd', fzf.lsp_definitions, '[G]oto [D]efinition')
  -- map('gO', fzf.lsp_document_symbols, 'Open Document Symbols')
  -- map('gW', fzf.lsp_workspace_symbols, 'Open Workspace Symbols')
  -- map('grt', fzf.lsp_typedefs, '[G]oto [T]ype Definition')

  vim.keymap.set('n', '<leader>rn', function()
    local inc_rename = require 'inc_rename'
    local cmd_name = (inc_rename.config and inc_rename.config.cmd_name) or 'IncRename'
    return ':' .. cmd_name .. ' ' .. vim.fn.expand '<cword>'
  end, {
    buffer = bufnr, -- Apply to the current buffer
    expr = true, -- Crucial: makes the function return the command string
    desc = 'LSP: [R]e[n]ame', -- Description
  })

  -- Note: The keymaps for document highlight and inlay hints remain in lspconfig.lua
  -- because they depend on checking client capabilities within the LspAttach callback.
end

return M
