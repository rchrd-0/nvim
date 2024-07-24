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
  {
    'kdheepak/lazygit.nvim',
    cmd = {
      'LazyGit',
      'LazyGitConfig',
      'LazyGitCurrentFile',
      'LazyGitFilter',
      'LazyGitFilterCurrentFile',
    },
    -- optional for floating window border decoration
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
    },
  },
}
