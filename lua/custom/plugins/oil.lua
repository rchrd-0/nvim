return {
  'stevearc/oil.nvim',
  enabled = true,
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
    -- vim.keymap.set('n', '<leader>\\', require('oil').open, { desc = 'Open parent directory in Oil' })
    -- vim.keymap.set('n', '\\', require('oil').toggle_float, { desc = 'Toggle Oil float' })
  },
  config = function()
    require('oil').setup {
      -- default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ['<C-s>'] = false,
        ['<C-h>'] = false,
        ['<C-t>'] = false,
        ['<C-l>'] = false,
        -- ['<BS>'] = { 'actions.parent', desc = 'Open parent directory' },
        ['<C-o>v'] = { 'actions.select', opts = { vertical = true }, desc = 'Open the entry in a vertical split' },
        ['<C-o>s'] = { 'actions.select', opts = { horizontal = true }, desc = 'Open the entry in a horizontal split' },
        ['<C-o>r'] = { 'actions.refresh', desc = '[R]efresh' },
        -- ['q'] = { 'actions.close' },
      },
      float = {
        win_options = {
          winblend = 0,
        },
      },
    }
    -- vim.keymap.set('n', '<leader>\\', require('oil').open, { desc = 'Open parent directory in Oil' })
    -- vim.keymap.set('n', '\\', require('oil').toggle_float, { desc = 'Toggle Oil float' })
  end,
}
