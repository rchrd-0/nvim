return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      zen = { enabled = true, toggles = {
        dim = false,
      } },
      dashboard = {
        enabled = true,
        width = 25,
        row = nil, -- dashboard position. nil for center
        col = nil, -- dashboard position. nil for center
        pane_gap = 4,
        preset = {
          keys = {
            {
              icon = ' ',
              key = 'f',
              desc = 'Find File',
              action = function()
                require('mini.pick').builtin.files()
              end,
            },
            { icon = ' ', key = 'n', desc = 'New File', action = ':ene | startinsert' },
            {
              icon = ' ',
              key = 'g',
              desc = 'Find Text',
              action = function()
                require('mini.pick').builtin.grep_live()
              end,
            },
            {
              icon = ' ',
              key = 'r',
              desc = 'Recent Files',
              action = function()
                require('mini.extra').pickers.oldfiles()
              end,
            },
            {
              icon = ' ',
              key = 'c',
              desc = 'Config',
              action = ":Pick files cwd=vim.fn.stdpath('config')",
              -- action = function()
              --   require('mini.pick').builtin.files { cwd = vim.fn.stdpath 'config' }
              -- end,
            },
            { icon = ' ', key = 's', desc = 'Restore Session', section = 'session' },
            { icon = '󰒲 ', key = 'L', desc = 'Lazy', action = ':Lazy', enabled = package.loaded.lazy ~= nil },
            { icon = ' ', key = 'q', desc = 'Quit', action = ':qa' },
          },
        },
        sections = {
          { section = 'keys', gap = 0, padding = 1 },
        },
      },
      picker = { enabled = true },
      styles = {
        zen = {
          minimal = false,
          backdrop = { transparent = true, blend = 30 },
        },
      },
    },
    keys = {
      {
        '<leader>z',
        function()
          Snacks.zen()
        end,
        desc = 'Toggle Zen Mode',
      },
      {
        '<leader>Z',
        function()
          Snacks.zen.zoom()
        end,
        desc = 'Toggle Zoom',
      },
    },
    init = function()
      vim.api.nvim_create_autocmd('User', {
        pattern = 'VeryLazy',
        callback = function()
          -- Setup some globals for debugging (lazy-loaded)
          _G.dd = function(...)
            Snacks.debug.inspect(...)
          end
          _G.bt = function()
            Snacks.debug.backtrace()
          end
          vim.print = _G.dd -- Override print to use snacks for `:=` command

          -- Create some toggle mappings
          Snacks.toggle.option('spell', { name = 'Spelling' }):map '<leader>us'
          Snacks.toggle.option('wrap', { name = 'Wrap' }):map '<leader>uw'
          Snacks.toggle.option('relativenumber', { name = 'Relative Number' }):map '<leader>uL'
          Snacks.toggle.diagnostics():map '<leader>ud'
          Snacks.toggle.line_number():map '<leader>ul'
          Snacks.toggle.option('conceallevel', { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }):map '<leader>uc'
          Snacks.toggle.treesitter():map '<leader>uT'
          Snacks.toggle.option('background', { off = 'light', on = 'dark', name = 'Dark Background' }):map '<leader>ub'
          Snacks.toggle.inlay_hints():map '<leader>uh'
          Snacks.toggle.indent():map '<leader>ug'
          Snacks.toggle.dim():map '<leader>uD'
        end,
      })
    end,
  },
}
