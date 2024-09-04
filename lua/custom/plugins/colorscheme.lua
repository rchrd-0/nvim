return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    lazy = false,
    opts = {
      style = 'night',
      dim_inactive = true,
      on_highlights = function(hl, colors)
        -- local util = require 'tokyonight.util'
        hl.LineNrAbove = {
          fg = colors.comment,
          -- fg = util.lighten(colors.fg_gutter, 0.7),
        }
        hl.LineNrBelow = {
          fg = colors.comment,
          --   -- fg = util.lighten(colors.fg_gutter, 0.7),
        }
      end,
    },
    -- init = function()
    -- vim.cmd.colorscheme 'tokyonight'
    -- vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    'rebelot/kanagawa.nvim',
    name = 'kanagawa',
    priority = 1000,
    lazy = false,
    opts = {
      dimInactive = true,
      terminalColors = true,
      transparent = true,
      overrides = function(colors)
        local theme = colors.theme
        return {
          Pmenu = { fg = theme.ui.shade0, bg = theme.ui.bg_p1 }, -- add `blend = vim.o.pumblend` to enable transparency
          PmenuSel = { fg = 'NONE', bg = theme.ui.bg_p2 },
          PmenuSbar = { bg = theme.ui.bg_m1 },
          PmenuThumb = { bg = theme.ui.bg_p2 },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = 'none',
            },
          },
        },
      },
    },
    init = function()
      vim.cmd.colorscheme 'kanagawa'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    lazy = false,
    -- init = function()
    --   vim.cmd.colorscheme 'rose-pine'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    lazy = false,
    opts = {
      flavour = 'mocha',
      dim_inactive = {
        enabled = true,
      },
    },
    -- init = function()
    --   vim.cmd.colorscheme 'catppuccin'
    --   vim.cmd.hi 'Comment gui=none'
    -- end,
  },
}
