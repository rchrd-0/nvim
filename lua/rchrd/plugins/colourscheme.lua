return {
  {
    'folke/tokyonight.nvim',
    name = 'tokyonight',
    priority = 1000,
    lazy = false,
    opts = {
      style = 'night',
      styles = {
        comments = { italic = false },
      },
      transparent = true,
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
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
    lazy = false,
    opts = {
      dim_inactive_windows = true,
      styles = {
        italic = false,
      },
    },
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
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      options = {
        transparent = false,
        dim_inactive = true,
        -- styles = {
        --   comments = 'italic',
        -- },
      },
      specs = {
        all = {
          -- sel0 = 'sel1',
          -- sel1 = 'sel0',
        },
        --   nightfox = {
        --     sel0 = '#3e5273',
        --   },
        --   duskfox = {
        --     sel0 = '#574d80', -- Custom selection color for duskfox
        --   },
        --   terafox = {
        --     sel0 = '#345353', -- Custom selection color for terafox
        --   },
        carbonfox = {
          sel0 = '#3a3a3a', -- Custom selection color for carbonfox
        },
      },
    },
    -- groups = {
    --   all = {
    --     Visual = { bg = '#4e5a75' },
    --   },
    -- },
  },
}
