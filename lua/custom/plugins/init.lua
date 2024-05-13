-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  { 'JoosepAlviste/nvim-ts-context-commentstring', opts = {
    enable_autocmd = false,
  } },
  {
    'christoomey/vim-tmux-navigator',
    vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<CR>'),
    vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<CR>'),
    vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<CR>'),
    vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<CR>'),
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {}, -- your configuration
  },
  {
    'akinsho/bufferline.nvim',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',
    opts = {
      options = {
        show_buffer_close_icons = false,
      },
    },
  },
  -- {
  --   'HiPhish/rainbow-delimiters.nvim',
  -- },
}
