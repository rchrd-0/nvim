return {
  { 'v', 'J', ":m '>+1<CR>gv=gv", { silent = true } },
  { 'v', 'K', ":m '<-2<CR>gv=gv", { silent = true } },
  { 'n', 'J', 'mzJ`z' },
  { 'n', '<C-d>', '<C-d>zz' },
  { 'n', '<C-u>', '<C-u>zz' },
  { 'n', 'n', 'nzzzv' },
  { 'n', 'N', 'Nzzzv' },
  { 'n', 'G', 'Gzz' },

  { 'n', '<M-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true } },
  { 'n', '<M-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true } },
  { 'n', '<M-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true } },
  { 'n', '<M-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true } },
  { 'n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true } },
  { 'n', '<M-[>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },
  { 'n', '<M-]>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },

  { 'n', '<Esc>', '<cmd>nohlsearch<CR>' },
  { 't', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } },

  { 'n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' } },

  { 'n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' } },
  { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
}
