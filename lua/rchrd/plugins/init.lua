return {
  require 'rchrd.plugins.lsp.lspconfig',

  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      -- Disable default mappings
      vim.g.tmux_navigator_no_mappings = 1
    end,
    vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true }),
  },
}
