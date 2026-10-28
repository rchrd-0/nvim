return {
  {
    "smart-splits-nvim/smart-splits.nvim",
    version = "^3.0.0",
    -- tmux needs its Neovim pane marker before the first navigation key.
    lazy = false,
    dependencies = {
      {
        "adriankarlen/smart-splits-backend-herdr",
        main = "smart-splits-backend-herdr",
        opts = {},
      },
      {
        "smart-splits-nvim/backend-tmux",
        main = "smart-splits-backend-tmux",
        opts = {},
      },
      {
        "rawnly/smart-splits-backend-rex",
        main = "smart-splits-backend-rex",
        opts = {},
      },
    },
    opts = {
      move = { at_edge = "wrap" },
      mux = {
        backend = { "smart-splits-backend-herdr", "smart-splits-backend-tmux", "smart-splits-backend-rex" },
        -- This config also runs in terminals without a multiplexer.
        warn_if_unusable = false,
      },
    },
  },
}

-- Superseded by smart-splits; retained for reference.
--[=[
local in_herdr = vim.env.HERDR_ENV == "1"

return {
  {
    "christoomey/vim-tmux-navigator",
    cond = not in_herdr,

    init = function()
      vim.g.tmux_navigator_no_mappings = 1
    end,

    -- keys = {
    --   { "<M-h>", "<cmd>TmuxNavigateLeft<CR>", desc = "Navigate left" },
    --   { "<M-j>", "<cmd>TmuxNavigateDown<CR>", desc = "Navigate down" },
    --   { "<M-k>", "<cmd>TmuxNavigateUp<CR>", desc = "Navigate up" },
    --   { "<M-l>", "<cmd>TmuxNavigateRight<CR>", desc = "Navigate right" },
    --   { "<M-\\>", "<cmd>TmuxNavigatePrevious<CR>", desc = "Navigate previous" },
    -- },
  },

  {
    "lmilojevicc/herdr-splits.nvim",
    enabled = true,
    cond = in_herdr,
    event = "VeryLazy",

    opts = {
      at_edge = "wrap",
      nav_at_edge = "wrap",

      nav_keys = {
        left = "<M-h>",
        down = "<M-j>",
        up = "<M-k>",
        right = "<M-l>",
      },

      unzoom_on_nav = true,
      auto_sync_herdr = true,
    },

    build = ':lua require("herdr-splits").sync_herdr()',

    -- keys = {
    --   {
    --     "<M-h>",
    --     function()
    --       require("herdr-splits").move_cursor_left()
    --     end,
    --     desc = "Navigate left",
    --   },
    --   {
    --     "<M-j>",
    --     function()
    --       require("herdr-splits").move_cursor_down()
    --     end,
    --     desc = "Navigate down",
    --   },
    --   {
    --     "<M-k>",
    --     function()
    --       require("herdr-splits").move_cursor_up()
    --     end,
    --     desc = "Navigate up",
    --   },
    --   {
    --     "<M-l>",
    --     function()
    --       require("herdr-splits").move_cursor_right()
    --     end,
    --     desc = "Navigate right",
    --   },
    -- },
  },
}
]=]
