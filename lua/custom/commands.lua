local M = {}

function M.close_all_buffers_but_current()
  local current = vim.fn.bufnr '%'
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  end
end

function M.delete_other_buffers()
  local current = vim.api.nvim_get_current_buf()
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= current and vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
      require('mini.bufremove').delete(bufnr, false)
    end
  end
end

function M.setup()
  vim.api.nvim_command 'aunmenu PopUp.How-to\\ disable\\ mouse'
  vim.api.nvim_command 'aunmenu PopUp.-1-'

  -- highlight yank
  vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
    callback = function()
      vim.highlight.on_yank()
    end,
  })

  -- remember folds
  local remember_folds = vim.api.nvim_create_augroup('remember_folds', { clear = true })
  vim.api.nvim_create_autocmd('BufWinLeave', {
    group = remember_folds,
    pattern = '*.*',
    command = 'mkview',
  })
  vim.api.nvim_create_autocmd('BufWinEnter', {
    group = remember_folds,
    pattern = '*.*',
    command = 'silent! loadview',
  })

  -- :Bd
  vim.api.nvim_create_user_command('Bd', function(opts)
    if opts.args ~= '' then
      require('mini.bufremove').delete(tonumber(opts.args), false)
    else
      require('mini.bufremove').delete()
    end
  end, { nargs = '?' })

  -- :Bo
  vim.api.nvim_create_user_command('Bo', M.delete_other_buffers, {})
end

return M
