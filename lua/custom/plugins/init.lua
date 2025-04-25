-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    opts = {
      enable_autocmd = false,
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
      -- { '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', desc = 'Delete Other Buffers' },
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
  {
    'rmagatti/auto-session',
    lazy = false,
    dependencies = {
      'nvim-telescope/telescope.nvim', -- Only needed if you want to use sesssion lens
    },
    keys = {
      -- Will use Telescope if installed or a vim.ui.select picker otherwise
      { '<leader>wr', '<cmd>SessionSearch<CR>', desc = 'Session search' },
      { '<leader>wR', '<cmd>SessionRestore<CR>', desc = 'Session restore' },
      { '<leader>wv', '<cmd>SessionSave<CR>', desc = 'Save session' },
      { '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
    },
    ---enables autocomplete for opts
    ---@module "auto-session"
    ---@type AutoSession.Config
    opts = {
      bypass_save_filetypes = { 'oil', 'netrw', '' },
      show_auto_restore_notif = true,
      -- ⚠️ This will only work if Telescope.nvim is installed
      -- The following are already the default values, no need to provide them if these are already the settings you want.
      session_lens = {
        -- If load_on_setup is false, make sure you use `:SessionSearch` to open the picker as it will initialize everything first
        load_on_setup = true,
        previewer = false,
        mappings = {
          -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
          delete_session = { 'i', '<C-D>' },
          alternate_session = { 'i', '<C-S>' },
          copy_session = { 'i', '<C-Y>' },
        },
        -- Can also set some Telescope picker options
        -- For all options, see: https://github.com/nvim-telescope/telescope.nvim/blob/master/doc/telescope.txt#L112
        theme_conf = {
          border = true,
          -- layout_config = {
          --   width = 0.8, -- Can set width and height as percent of window
          --   height = 0.5,
          -- },
        },
      },
      no_restore_cmds = {
        function()
          require 'oil'
        end,
      },
    },
  },
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
  {
    'mistweaverco/kulala.nvim',
    keys = {
      { '<leader>Rs', desc = '[S]end request' },
      { '<leader>Ra', desc = 'Send [a]ll requests' },
      { '<leader>Ro', desc = '[O]pen scratchpad' },
    },
    ft = { 'http', 'rest' },
    opts = {
      -- your configuration comes here
      global_keymaps = true,
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
    'sindrets/diffview.nvim',
    opts = {},
  },
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = function()
      local actions = require('fzf-lua').actions

      return {
        actions = {
          files = {
            [1] = true,
            ['enter'] = actions.file_edit,
          },
        },
      }
    end,
  },
}
