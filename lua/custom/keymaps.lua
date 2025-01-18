return {
  { 'n', '<M-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true } },
  { 'n', '<M-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true } },
  { 'n', '<M-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true } },
  { 'n', '<M-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true } },
  { 'n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true } },

  { 'n', '<Esc>', '<cmd>nohlsearch<CR>' },
  { 't', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } },

  { 'n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' } },

  { 'n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' } },
  { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
}
