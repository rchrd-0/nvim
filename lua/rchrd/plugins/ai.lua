return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    enabled = true,
    opts = {
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = '<M-l>',
          accept_word = '<M-.>',
          accept_line = false,
          next = '<M-n>',
          prev = '<M-p>',
          dismiss = '<C-x>',
        },
        panel = {
          enabled = false,
          auto_refresh = false,
        },
      },
    },
  },
  {
    'folke/sidekick.nvim',
    opts = {
      -- add any options here
      cli = {
        mux = {
          backend = 'tmux',
          enabled = true,
        },
      },
    },
    keys = {
      {
        '<tab>',
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require('sidekick').nes_jump_or_apply() then
            return '<Tab>' -- fallback to normal tab
          end
        end,
        expr = true,
        desc = 'Goto/Apply Next Edit Suggestion',
      },
      {
        '<c-.>',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle',
        mode = { 'n', 't', 'i', 'x' },
      },
      {
        '<leader>aa',
        function()
          require('sidekick.cli').toggle()
        end,
        desc = 'Sidekick Toggle CLI',
      },
      {
        '<leader>as',
        function()
          require('sidekick.cli').select()
        end,
        -- Or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } })
        desc = 'Select CLI',
      },
      {
        '<leader>ad',
        function()
          require('sidekick.cli').close()
        end,
        desc = 'Detach a CLI Session',
      },
      {
        '<leader>at',
        function()
          require('sidekick.cli').send { msg = '{this}' }
        end,
        mode = { 'x', 'n' },
        desc = 'Send This',
      },
      {
        '<leader>af',
        function()
          require('sidekick.cli').send { msg = '{file}' }
        end,
        desc = 'Send File',
      },
      {
        '<leader>av',
        function()
          require('sidekick.cli').send { msg = '{selection}' }
        end,
        mode = { 'x' },
        desc = 'Send Visual Selection',
      },
      {
        '<leader>ap',
        function()
          require('sidekick.cli').prompt()
        end,
        mode = { 'n', 'x' },
        desc = 'Sidekick Select Prompt',
      },
      -- Example of a keybinding to open Claude directly
      {
        '<leader>ac',
        function()
          require('sidekick.cli').toggle { name = 'claude', focus = true }
        end,
        desc = 'Sidekick Toggle Claude',
      },
    },
  },
  -- {
  --   'milanglacier/minuet-ai.nvim',
  --   enabled = false,
  --   config = function()
  --     require('minuet').setup {
  --       virtualtext = {
  --         auto_trigger_ft = { '*' },
  --         keymap = {
  --           -- accept whole completion
  --           accept = '<M-l>',
  --           -- accept one line
  --           accept_line = '<M-.>',
  --           -- accept n lines (prompts for number)
  --           -- e.g. "A-z 2 CR" will accept 2 lines
  --           accept_n_lines = '<M-z>',
  --           -- Cycle to prev completion item, or manually invoke completion
  --           prev = '<M-n>',
  --           -- Cycle to next completion item, or manually invoke completion
  --           next = '<M-p>',
  --           dismiss = '<C-x>',
  --         },
  --       },
  --       provider = 'openai_compatible',
  --       request_timeout = 2.5,
  --       throttle = 1000, -- Increase to reduce costs and avoid rate limits
  --       debounce = 400, -- Increase to reduce costs and avoid rate limits
  --       provider_options = {
  --         openai_compatible = {
  --           api_key = 'OPENROUTER_API_KEY',
  --           -- end_point = 'https://openrouter.ai/api/v1/chat/completions',
  --           -- model = 'google/gemini-2.0-flash-001',
  --           -- model = 'moonshotai/kimi-k2',
  --           -- model = 'mistralai/codestral-2508',
  --           model = 'qwen/qwen3-coder',
  --           name = 'Openrouter',
  --           stream = true,
  --           optional = {
  --             -- max_tokens = 256,
  --             max_tokens = 256,
  --             top_p = 0.9,
  --             -- stop = { '\n\n' },
  --             provider = {
  --               -- Prioritize throughput for faster completion
  --               sort = 'throughput',
  --             },
  --           },
  --         },
  --       },
  --       -- provider_options = {
  --       --   openai_compatible = {
  --       --     name = 'Openrouter',
  --       --     end_point = 'https://openrouter.ai/api/v1/chat/completions',
  --       --     api_key = 'OPENROUTER_API_KEY',
  --       --     model = 'gpt-4.1-mini',
  --       --     system = 'see [Prompt] section for the default value',
  --       --     few_shots = 'see [Prompt] section for the default value',
  --       --     chat_input = 'See [Prompt Section for default value]',
  --       --     stream = true,
  --       --     optional = {
  --       --       -- pass any additional parameters you want to send to OpenAI request,
  --       --       -- e.g.
  --       --       -- stop = { 'end' },
  --       --       -- max_tokens = 256,
  --       --       -- top_p = 0.9,
  --       --     },
  --       --   },
  --       -- },
  --     }
  --   end,
  -- },
}
