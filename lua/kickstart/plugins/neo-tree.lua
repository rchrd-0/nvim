-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    {
      '\\',
      function()
        vim.cmd 'Neotree reveal right'
      end,
      desc = 'NeoTree reveal',
    },
  },
  opts = {
    filesystem = {
      window = {
        mappings = {
          ['\\'] = 'close_window',
          ['P'] = { 'toggle_preview', config = { use_float = false, use_image_nvim = true } },
        },
      },
      filtered_items = {
        hide_dotfiles = false,
        hide_hidden = false,
      },
    },
  },
}
