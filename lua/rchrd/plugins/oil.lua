return {
  'stevearc/oil.nvim',
  enabled = true,
  lazy = false,
  dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
  cmd = 'Oil',
  keys = {
    {
      '\\',
      function()
        require('oil').toggle_float()
      end,
      { desc = 'Toggle Oil float' },
    },
    {
      '<leader>\\',
      function()
        require('oil').open()
      end,
      { desc = 'Open parent directory in Oil' },
    },
  },
  opts = {
    default_file_explorer = true,
    view_options = {
      show_hidden = true,
    },
    columns = {
      'icon',
    },
    keymaps = {
      ['<C-s>'] = false,
      ['<C-h>'] = false,
      ['<C-t>'] = false,
      ['<C-l>'] = false,
      ['<C-o>v'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
      ['<C-o>s'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
      ['<C-o>r'] = { 'actions.refresh', desc = '[R]efresh' },
    },
    float = {
      win_options = {
        winblend = 0,
      },
    },
  },
}
