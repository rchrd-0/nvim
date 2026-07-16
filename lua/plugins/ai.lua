vim.g.suggestion_provider = "copilot"

local suggestion_provider = vim.g.suggestion_provider

local disabled_filetypes = {
  "bigfile",
  "snacks_input",
  "snacks_notif",
  "snacks_picker_input",
  "trouble",
}

local disabled_paths = {
  "$HOME/Library/CloudStorage/OneDrive-Personal/05_Obsidian",
}

local suggestion_keymap = {
  accept = "<M-l>",
  accept_word = false,
  accept_line = "<M-.>",
  next = "<M-]>",
  prev = "<M-[>",
  dismiss = "<C-]>",
}

local openrouter_profiles = {
  qwen_coder = {
    model = "qwen/qwen3-coder-next",
    stream = true,
    optional = {
      max_tokens = 128,
      temperature = 0,
      reasoning = { effort = "none" },
    },
  },
  codestral = {
    model = "mistralai/codestral-2508",
    stream = true,
    optional = {
      max_tokens = 128,
      temperature = 0,
    },
  },
  deepseek = {
    model = "deepseek/deepseek-chat",
    stream = true,
    optional = {
      max_tokens = 128,
      temperature = 0,
      reasoning = { effort = "none" },
    },
  },
  qwen_flash = {
    model = "qwen/qwen3-coder-flash",
    stream = true,
    optional = {
      max_tokens = 64,
      temperature = 0,
      reasoning = { effort = "none" },
    },
  },
}

-- local openrouter_profile = openrouter_profiles.qwen_flash
local openrouter_profile = openrouter_profiles.qwen_coder
-- local openrouter_profile = openrouter_profiles.codestral
-- local openrouter_profile = openrouter_profiles.deepseek

local function is_disabled_path(bufname)
  for _, path in ipairs(disabled_paths) do
    if string.find(bufname, vim.fn.expand(path), 1, true) ~= nil then
      return true
    end
  end

  return false
end

local function is_enabled_for_buffer()
  return not is_disabled_path(vim.api.nvim_buf_get_name(0))
end

local function disabled_filetype_map()
  local filetypes = {}

  for _, filetype in ipairs(disabled_filetypes) do
    filetypes[filetype] = false
  end

  return filetypes
end

local function setup_minuet_ai_accept()
  LazyVim.cmp.actions.ai_accept = function()
    local virtualtext = require("minuet.virtualtext").action

    if virtualtext.is_visible() then
      LazyVim.create_undo()
      virtualtext.accept()
      return true
    end
  end
end

local function copilot_nes_jump_or_apply()
  local ok, nes_api = pcall(require, "copilot.nes.api")

  if not ok then
    return false
  end

  local ok_jump, jumped = pcall(nes_api.nes_walk_cursor_start_edit)

  if ok_jump and jumped then
    return true
  end

  local ok_apply, applied = pcall(nes_api.nes_apply_pending_nes)

  if ok_apply and applied then
    pcall(nes_api.nes_walk_cursor_end_edit)
    return true
  end

  return false
end

local function setup_copilot_ai_nes()
  LazyVim.cmp.actions.ai_nes = function()
    if copilot_nes_jump_or_apply() then
      return true
    end
  end
end

return {
  {
    "zbirenbaum/copilot.lua",
    enabled = suggestion_provider == "copilot",
    dependencies = {
      {
        "copilotlsp-nvim/copilot-lsp",
        -- init = function()
        --   vim.g.copilot_nes_debounce = 500
        -- end,
      },
    },
    -- init = setup_copilot_ai_nes,
    keys = {
      -- {
      --   "<tab>",
      --   function()
      --     return copilot_nes_jump_or_apply() and "" or "<tab>"
      --   end,
      --   mode = { "n" },
      --   expr = true,
      --   desc = "Goto/Apply Next Edit Suggestion",
      -- },
    },
    opts = function(_, opts)
      opts.suggestion = vim.tbl_deep_extend("force", opts.suggestion or {}, {
        enabled = true,
        auto_trigger = true,
        keymap = suggestion_keymap,
      })
      opts.filetypes = disabled_filetype_map()
      opts.should_attach = function(_, bufname)
        return not is_disabled_path(bufname)
      end
      -- opts.nes = vim.tbl_deep_extend("force", opts.nes or {}, {
      --   enabled = true,
      --   auto_trigger = true,
      --   keymap = {
      --     accept_and_goto = false,
      --     accept = false,
      --     dismiss = false,
      --   },
      -- })
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = function(_, opts)
      opts = opts or {}
      opts.nes = vim.tbl_deep_extend("force", opts.nes or {}, {
        enabled = true,
      })

      -- if suggestion_provider == "copilot" then
      --   setup_copilot_ai_nes()
      -- end

      return opts
    end,
  },
  {
    "milanglacier/minuet-ai.nvim",
    enabled = suggestion_provider == "minuet",
    init = setup_minuet_ai_accept,
    opts = {
      enable_predicates = {
        is_enabled_for_buffer,
      },
      virtualtext = {
        auto_trigger_ft = { "*" },
        auto_trigger_ignore_ft = disabled_filetypes,
        keymap = {
          accept = suggestion_keymap.accept,
          accept_line = suggestion_keymap.accept_line,
          accept_n_lines = nil,
          next = suggestion_keymap.next,
          prev = suggestion_keymap.prev,
          dismiss = suggestion_keymap.dismiss,
        },
        show_on_completion_menu = false,
      },

      -- SPEED
      -- context_window = 2500,
      -- throttle = 900,
      -- debounce = 250,

      -- BASELINE
      context_window = 6000,
      throttle = 1200,
      debounce = 350,

      -- QUIET / CHEAPER
      -- context_window = 8000,
      -- throttle = 1800,
      -- debounce = 600,

      provider = "openai_compatible",
      -- provider = "openai_fim_compatible",
      provider_options = {
        openai_compatible = vim.tbl_deep_extend("force", {
          name = "Openrouter",
          end_point = "https://openrouter.ai/api/v1/chat/completions",
          api_key = "OPENROUTER_API_KEY",
        }, openrouter_profile),
        openai_fim_compatible = {
          model = "mercury-edit-2",
          end_point = "https://api.inceptionlabs.ai/v1/fim/completions",
          api_key = "INCEPTION_LABS_API_KEY",
          stream = true,
        },
      },
    },
  },
}
