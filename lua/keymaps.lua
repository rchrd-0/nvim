vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

vim.keymap.set('n', '<M-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<M-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<M-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<M-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' })

vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { noremap = true, desc = '[Y]ank to system clipboard' })

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'G', 'Gzz')

vim.keymap.set('n', '[b', ':bp<CR>', { desc = 'Move to the previous [b]uffer', silent = true })
vim.keymap.set('n', ']b', ':bnext<CR>', { desc = 'Move to the next [b]uffer', silent = true })
vim.keymap.set('n', '[t', ':tabnext<CR>', { desc = 'Move to the previous [t]ab', silent = true })
vim.keymap.set('n', ']t', ':tabprevious<CR>', { desc = 'Move to the next [t]ab', silent = true })
vim.keymap.set('n', '<M-[>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true })
vim.keymap.set('n', '<M-]>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true })

vim.keymap.set('n', 'ZA', ':qa<CR>', { silent = true, noremap = true })
