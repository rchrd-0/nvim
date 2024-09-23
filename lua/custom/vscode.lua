print '[sourcing vscode.lua]'

local function ping()
  print 'pong'
end
local vscode = require 'vscode'

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', function()
  vim.cmd 'nohlsearch'
  vscode.call 'removeSecondaryCursors'
end, { silent = true })

vim.keymap.set('n', '<M-h>', function()
  vscode.call 'workbench.action.navigateLeft'
end)
vim.keymap.set('n', '<M-l>', function()
  vscode.call 'workbench.action.navigateRight'
end)
vim.keymap.set('n', '<M-j>', function()
  vscode.call 'workbench.action.navigateDown'
end)
vim.keymap.set('n', '<M-k>', function()
  vscode.call 'workbench.action.navigateUp'
end)
vim.keymap.set('n', '<M-w>', function()
  vscode.call 'workbench.action.focusNextGroup'
end)
vim.keymap.set('n', ']t', function()
  vscode.call 'workbench.action.nextEditor'
end)
vim.keymap.set('n', '[t', function()
  vscode.call 'workbench.action.previousEditor'
end)

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
      { out, 'WarningMsg' },
      { '\nPress any key to exit...' },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require('lazy').setup {
  spec = {
    {
      'echasnovski/mini.nvim',
      config = function()
        require('mini.surround').setup()
      end,
    },
  },
}
