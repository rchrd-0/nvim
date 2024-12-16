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
    'windwp/nvim-ts-autotag',
    opts = {},
  },
  {
    'luckasRanarison/tailwind-tools.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-telescope/telescope.nvim', -- optional
      'neovim/nvim-lspconfig', -- optional
    },
    build = ':UpdateRemotePlugins',
    -- opts = {}, -- your configuration
    opts = {
      server = {
        override = false,
        -- settings = {
        --   classAttributes = { '.*ClassName' },
        --   validate = true,
        -- },
      },
    },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VeryLazy',
    version = '*',
    dependencies = 'nvim-tree/nvim-web-devicons',

    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
      { '[T', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
      { ']T', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
      { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle Pin' },
      { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
      { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
      { '<leader>br', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete Buffers to the Right' },
      { '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete Buffers to the Left' },
    },
    opts = {
      options = {
        always_show_bufferline = true,
        show_buffer_close_icons = false,
        diagnostics = 'nvim_lsp',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match 'error' and '  ' or level:match 'warning' and '  ' or '  '
          return ' ' .. icon .. ' ' .. count
        end,
      },
    },
    config = function(_, opts)
      require('bufferline').setup(opts)
      -- Fix bufferline when restoring a session
      vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
        callback = function()
          vim.schedule(function()
            pcall(nvim_bufferline)
          end)
        end,
      })
    end,
  },
  -- {
  --   'kdheepak/lazygit.nvim',
  --   cmd = {
  --     'LazyGit',
  --     'LazyGitConfig',
  --     'LazyGitCurrentFile',
  --     'LazyGitFilter',
  --     'LazyGitFilterCurrentFile',
  --   },
  --   -- optional for floating window border decoration
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --   },
  --   -- setting the keybinding for LazyGit with 'keys' is recommended in
  --   -- order to load the plugin when the command is run for the first time
  --   keys = {
  --     { '<leader>lg', '<cmd>LazyGit<cr>', desc = '[L]azy[G]it' },
  --   },
  -- },
  -- {
  --   'joeldotdias/jsdoc-switch.nvim',
  --   ft = { -- Add or remove filetypes from this section depending on your requirements
  --     'javascript',
  --     'javascriptreact',
  --   },
  --   config = function()
  --     require('jsdoc-switch').setup() -- setup() must be called to create default keymaps
  --   end,
  -- },
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
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
      { '<leader>ws', '<cmd>SessionSave<CR>', desc = 'Save session' },
      { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
    config = function()
      require('auto-session').setup {
        auto_session_suppress_dirs = { '~/', '~/Projects', '~/Downloads', '/' },
        session_lens = {
          -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
          mappings = {
            -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
            delete_session = { 'i', '<C-D>' },
            alternate_session = { 'i', '<C-S>' },
          },
        },
      }
    end,
  },
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }, -- use if prefer nvim-web-devicons
    config = function()
      require('oil').setup {
        default_file_explorer = false,
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
      -- vim.keymap.set('n', '\\', '<CMD>Oil<CR>', { desc = 'Open parent directory' })
      vim.keymap.set('n', '<leader>\\', require('oil').toggle_float, { desc = 'Open parent directory in Oil' })
    end,
  },
  -- lazy.nvim
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    opts = {
      messages = {
        enabled = true,
      },
      routes = {
        {
          view = 'notify',
          filter = { event = 'msg_showmode' },
        },
        -- {
        --   view = 'split',
        --   filter = { event = 'msg_show', min_height = 5 },
        -- },
      },
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = false, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },

      views = {
        -- cmdline_popup = {
        --   position = {
        --     row = 20,
        --     col = '50%',
        --   },
        --   border = {
        --     style = 'rounded',
        --     -- padding = { 1, 2 },
        --   },
        -- },
        cmdline_popup = {
          position = {
            row = 15,
            col = '50%',
          },
          size = {
            width = 60,
            height = 'auto',
          },
          border = {
            style = 'rounded',
            -- padding = { 0, 1 },
            -- text = {
            --   top = 'ASDFS',
            --   top_align = 'center',
            --   bottom = 'ASDFASDF',
            --   bottom_align = 'center',
            -- },
          },
          win_options = {
            winhighlight = { FloatTitle = '' },
          },
        },
        popupmenu = {
          relative = 'editor',
          position = {
            row = 18,
            col = '50%',
          },
          size = {
            width = 60,
            height = 10,
          },
          border = {
            style = 'rounded',
            -- padding = { 1, 1 },
          },
          win_options = {
            winhighlight = { Normal = 'Normal', FloatBorder = 'DiagnosticInfo' },
          },
        },
      },
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      'MunifTanjim/nui.nvim',
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      -- 'rcarriga/nvim-notify',
    },
  },
  -- {
  --   'folke/flash.nvim',
  --   event = 'VeryLazy',
  --   opts = {},
  --   -- stylua: ignore
  --   keys = {
  --     { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
  --     { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
  --     { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
  --     { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
  --     { "<M-e>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
  --   },
  -- },
  -- {
  --   'hiphish/rainbow-delimiters.nvim',
  -- },
  -- {
  --   'norcalli/nvim-colorizer.lua',
  --   opts = {
  --     'css',
  --     'javascript',
  --     'javascriptreact',
  --     'typescript',
  --     'typescriptreact',
  --     'vue',
  --     'html',
  --   },
  --   mode = 'background',
  -- },
}
