return {
  require 'rchrd.plugins.lsp.lspconfig',

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {
      signs = true,
      keywords = {
        dev = { icon = ' ', color = 'hint', alt = { 'INFO' } },
        DEV = { icon = ' ', color = 'hint', alt = { 'INFO' } },
      },
    },
  },
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      -- Disable default mappings
      vim.g.tmux_navigator_no_mappings = 1
    end,
    vim.keymap.set('n', '<M-h>', ':TmuxNavigateLeft<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-j>', ':TmuxNavigateDown<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-k>', ':TmuxNavigateUp<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-l>', ':TmuxNavigateRight<CR>', { noremap = true, silent = true }),
    vim.keymap.set('n', '<M-\\>', ':TmuxNavigatePrevious<CR>', { noremap = true, silent = true }),
  },
  {
    'smjonas/inc-rename.nvim',
    opts = {
      keys = {
        vim.keymap.set('n', '<leader>rn', function()
          return ':IncRename ' .. vim.fn.expand '<cword>'
        end, { expr = true }),
      },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    -- optional = true,
    opts = {
      file_types = { 'markdown', 'copilot-chat', 'codecompanion' },
    },
    ft = { 'markdown', 'copilot-chat', 'codecompanion' },
  },
  {
    'numToStr/Comment.nvim',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    opts = {},
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  {
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'sindrets/diffview.nvim',
    opts = {},
  },
  -- {
  --   'm4xshen/hardtime.nvim',
  --   lazy = false,
  --   dependencies = { 'MunifTanjim/nui.nvim' },
  --   opts = {},
  -- },
}
