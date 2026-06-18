-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.filetype.add({
  extension = {
    pac = "javascript",
  },
})

vim.g.snacks_animate = false
vim.g.lazyvim_picker = "auto"
vim.g.ai_cmp = false
vim.g.lazyvim_python_lsp = "pyright"
vim.g.lazyvim_prettier_needs_config = true

local opt = vim.opt

opt.clipboard = ""
opt.list = true
-- opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }
opt.inccommand = "split"
opt.scrolloff = 10
-- opt.foldmethod = "indent"
opt.colorcolumn = "80,100"
opt.wrap = true
opt.signcolumn = "yes:2"
-- opt.winborder = "single"
