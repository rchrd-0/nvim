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
    vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true }),
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  -- {
  --   'HiPhish/rainbow-delimiters.nvim',
  --   opts = {},
  -- },
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
  {
    'joeldotdias/jsdoc-switch.nvim',
    ft = { -- Add or remove filetypes from this section depending on your requirements
      'javascript',
      'javascriptreact',
    },
    config = function()
      require('jsdoc-switch').setup() -- setup() must be called to create default keymaps
    end,
  },
  {
    'folke/trouble.nvim',
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = 'Trouble',
    keys = {
      {
        '<leader>xx',
        '<cmd>Trouble diagnostics toggle<cr>',
        desc = 'Diagnostics (Trouble)',
      },
      {
        '<leader>xX',
        '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
        desc = 'Buffer Diagnostics (Trouble)',
      },
      {
        '<leader>cs',
        '<cmd>Trouble symbols toggle focus=false<cr>',
        desc = 'Symbols (Trouble)',
      },
      {
        '<leader>cl',
        '<cmd>Trouble lsp toggle focus=false win.position=right<cr>',
        desc = 'LSP Definitions / references / ... (Trouble)',
      },
      {
        '<leader>xL',
        '<cmd>Trouble loclist toggle<cr>',
        desc = 'Location List (Trouble)',
      },
      {
        '<leader>xQ',
        '<cmd>Trouble qflist toggle<cr>',
        desc = 'Quickfix List (Trouble)',
      },
    },
  },
}
