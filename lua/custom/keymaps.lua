local function close_all_buffers_but_current()
  local current = vim.fn.bufnr '%'
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

return {
  --  See `:help wincmd` for a list of all window commands
  { 'n', '<M-h>', ':wincmd h<CR>', { desc = 'Move focus to the left window' } },
  { 'n', '<M-l>', ':wincmd l<CR>', { desc = 'Move focus to the right window' } },
  { 'n', '<M-j>', ':wincmd j<CR>', { desc = 'Move focus to the lower window' } },
  { 'n', '<M-k>', ':wincmd k<CR>', { desc = 'Move focus to the upper window' } },
  { 'n', '<M-w>', '<C-w>w', { desc = 'Move focus to the next window' } },

  { 'v', 'J', ":m '>+1<CR>gv=gv", { silent = true } },
  { 'v', 'K', ":m '<-2<CR>gv=gv", { silent = true } },
  { 'n', 'J', 'mzJ`z' },
  { 'n', '<C-d>', '<C-d>zz' },
  { 'n', '<C-u>', '<C-u>zz' },
  { 'n', 'n', 'nzzzv' },
  { 'n', 'N', 'Nzzzv' },
  { 'n', 'G', 'Gzz' },
  { 'n', '[t', ':bp<CR>', { desc = 'Move to the previous buffer', silent = true } },
  { 'n', ']t', ':bnext<CR>', { desc = 'Move to the next buffer', silent = true } },
  { 'n', '<M-[>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },
  { 'n', '<M-]>', ':buffer #<CR>', { desc = 'Switch to the alternate buffer', silent = true } },

  { 'n', '<C-W>O', close_all_buffers_but_current, { desc = 'Close all buffers except current', noremap = true, silent = true } },
  { 'n', '<leader>bd', ':lua MiniBufremove.delete()<CR>', { desc = '[B]uffer [d]elete' } },

  -- diagnostics
  { 'n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' } },
  { 'n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' } },
  { 'n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' } },
  { 'n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' } },
}
