-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
local function setup_colorscheme(name)
  vim.cmd.colorscheme(name)
  vim.cmd.hi 'Comment gui=none'
end

local active_colorscheme = 'kanagawa'

return {
  {
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
    init = function()
      if active_colorscheme == 'tokyonight' then
        setup_colorscheme 'tokyonight'
      end
    end,
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
      if active_colorscheme == 'kanagawa' then
        setup_colorscheme 'kanagawa'
      end
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    lazy = false,
    init = function()
      if active_colorscheme == 'rose-pine' then
        setup_colorscheme 'rose-pine'
      end
    end,
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
    init = function()
      if active_colorscheme == 'catppuccin' then
        setup_colorscheme 'catppuccin'
      end
    end,
  },
}
