local commands = require 'custom.commands'

-- local function close_all_buffers_but_current()
--   local current = vim.fn.bufnr '%'
--   for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--     if bufnr ~= current and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
--       vim.api.nvim_buf_delete(bufnr, { force = true })
--     end
--   end
-- end

-- mini-bufremove implementation
-- local function delete_other_buffers()
--   local current = vim.api.nvim_get_current_buf()
--   for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
--     if bufnr ~= current and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
--       require('mini.bufremove').delete(bufnr, false)
--     end
--   end
-- end

return {
  --  See `:help wincmd` for a list of all window commands
  { 'n', '<M-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' } },
  { 'n', '<M-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' } },
  { 'n', '<M-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window' } },
  { 'n', '<M-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window' } },
  { 'n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' } },

  { 'n', '<leader>y', '"+y', { noremap = true, desc = '[Y]ank to system clipboard' } },
  { 'v', '<leader>y', '"+y', { noremap = true, desc = '[Y]ank selection to system clipboard' } },

  -- { 'v', 'J', ":m '>+1<CR>gv=gv", { silent = true } },
  -- { 'v', 'K', ":m '<-2<CR>gv=gv", { silent = true } }, { 'n', 'J', 'mzJ`z' },
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
  { 'n', 'ZA', ':qa<CR>', { silent = true, noremap = true } },

  { 'n', '<C-W>O', commands.delete_other_buffers, { desc = 'Close [o]ther buffers', noremap = true, silent = true } },
  { 'n', '<leader>bd', ':lua MiniBufremove.delete()<CR>', { desc = '[B]uffer [d]elete', noremap = true, silent = true } },
  { 'n', '<leader>bo', commands.delete_other_buffers, { desc = '[B]uffer delete [o]thers', noremap = true, silent = true } },

  -- diagnostics
  { 'n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' } },
  { 'n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' } },
  { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
  { 'n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' } },
}
