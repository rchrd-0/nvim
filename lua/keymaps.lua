return {
  { 'n', '<Esc>', '<cmd>nohlsearch<CR>' },
  { 't', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' } },

  -- { 'n', '<M-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' } },
  -- { 'n', '<M-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' } },
  -- { 'n', '<M-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window' } },
  -- { 'n', '<M-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window' } },
  { 'n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' } },
  { 'n', '<C-w>"', '<C-w>s', { desc = 'Split window' } },
  { 'n', '<C-w>%', '<C-w>v', { desc = 'Split window vertically' } },

  { { 'n', 'v' }, '<leader>y', '"+y', { noremap = true, desc = '[Y]ank to system clipboard' } },
  { { 'n', 'v' }, '<leader>Y', '"+Y', { noremap = true, desc = '[Y]ank line to system clipboard' } },
  { { 'n', 'v' }, '<leader>d', '"_d', { noremap = true, desc = '[D]elete to black hole register' } },

  { 'n', '<C-d>', '<C-d>zz' },
  { 'n', '<C-u>', '<C-u>zz' },
  { 'n', 'n', 'nzzzv' },
  { 'n', 'N', 'Nzzzv' },
  { 'n', 'G', 'Gzz' },

  { 'n', '[b', ':bp<CR>', { desc = 'Move to the previous [b]uffer', silent = true } },
  { 'n', ']b', ':bnext<CR>', { desc = 'Move to the next [b]uffer', silent = true } },
  { 'n', '[t', ':tabnext<CR>', { desc = 'Move to the previous [t]ab', silent = true } },
  { 'n', ']t', ':tabprevious<CR>', { desc = 'Move to the next [t]ab', silent = true } },
  { 'n', '<M-[>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },
  { 'n', '<M-]>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },
  { 'n', '<leader>bd', ':lua Snacks.bufdelete()<CR>', { desc = '[B]uffer [d]elete', noremap = true, silent = true } },
  { 'n', '<leader>bD', ':lua Snacks.bufdelete.all()<CR>', { desc = '[B]uffer [d]elete all', noremap = true, silent = true } },
  { 'n', '<leader>bo', ':lua Snacks.bufdelete.other()<CR>', { desc = '[B]uffer [d]elete [o]thers', noremap = true, silent = true } },

  { 'n', 'ZA', ':qa<CR>', { silent = true, noremap = true } },

  { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },

  { 'n', 's', '<Nop>', { noremap = true } },
}
