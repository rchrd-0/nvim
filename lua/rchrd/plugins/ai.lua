return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
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
  -- {
  --   'milanglacier/minuet-ai.nvim',
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
  --           accept_n_lines = '<A-z>',
  --           -- Cycle to prev completion item, or manually invoke completion
  --           prev = '<M-n>',
  --           -- Cycle to next completion item, or manually invoke completion
  --           next = '<M-p>',
  --           dismiss = '<C-x>',
  --         },
  --       },
  --       provider = 'openai_compatible',
  --       request_timeout = 2.5,
  --       -- throttle = 1000, -- Increase to reduce costs and avoid rate limits
  --       -- debounce = 400, -- Increase to reduce costs and avoid rate limits
  --       provider_options = {
  --         openai_compatible = {
  --           api_key = 'OPENROUTER_API_KEY',
  --           end_point = 'https://openrouter.ai/api/v1/chat/completions',
  --           model = 'google/gemini-2.0-flash-001',
  --           name = 'Openrouter',
  --           stream = true,
  --           optional = {
  --             -- max_tokens = 56,
  --             -- top_p = 0.9,
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
  -- {
  --   'olimorris/codecompanion.nvim',
  --   dependencies = {
  --     'nvim-treesitter/nvim-treesitter',
  --   },
  --   config = function()
  --     local default_model = 'google/gemini-2.5-pro-preview-03-25'
  --     local available_models = {
  --       'google/gemini-2.5-pro-preview-03-25',
  --       'google/gemini-2.5-flash-preview',
  --       'google/gemini-2.5-flash-preview:thinking',
  --       'anthropic/claude-3.7-sonnet',
  --       'anthropic/claude-3.7-sonnet:thinking',
  --       'anthropic/claude-3.5-sonnet',
  --       'openai/gpt-4.1',
  --       'openai/gpt-4.1-mini',
  --       'openai/gpt-4.1-nano',
  --       'openai/gpt-4o-mini',
  --     }
  --     local current_model = default_model
  --
  --     local function select_model()
  --       vim.ui.select(available_models, {
  --         prompt = 'Select  Model:',
  --       }, function(choice)
  --         if choice then
  --           current_model = choice
  --           vim.notify('Selected model: ' .. current_model)
  --         end
  --       end)
  --     end
  --
  --     require('codecompanion').setup {
  --       strategies = {
  --         chat = {
  --           adapter = 'openrouter',
  --           slash_commands = {
  --             ['file'] = {
  --               callback = 'strategies.chat.slash_commands.file',
  --               description = 'Select file(s)',
  --               opts = {
  --                 provider = 'mini_pick',
  --                 contains_code = true,
  --               },
  --             },
  --             ['buffer'] = {
  --               callback = 'strategies.chat.slash_commands.buffer',
  --               description = 'Select buffer(s)',
  --               opts = {
  --                 provider = 'mini_pick',
  --                 contains_code = true,
  --               },
  --             },
  --             ['help'] = {
  --               callback = 'strategies.chat.slash_commands.help',
  --               description = 'Select helpfile(s)',
  --               opts = {
  --                 provider = 'mini_pick',
  --                 contains_code = true,
  --               },
  --             },
  --           },
  --           keymaps = {
  --             send = {
  --               modes = { i = '<C-CR>' },
  --             },
  --           },
  --         },
  --         inline = {
  --           adapter = 'openrouter',
  --         },
  --       },
  --       default = {
  --         keymaps = {
  --           send = {
  --             modes = { i = '<C-CR>' },
  --           },
  --         },
  --       },
  --       adapters = {
  --         copilot = function()
  --           return require('codecompanion.adapters').extend('copilot', {
  --             schema = {
  --               model = {
  --                 default = 'claude-3.7-sonnet',
  --               },
  --             },
  --           })
  --         end,
  --         openrouter = function()
  --           return require('codecompanion.adapters').extend('openai_compatible', {
  --             env = {
  --               url = 'https://openrouter.ai/api',
  --               api_key = 'cmd:bw get password 1772c482-a837-407d-8888-b2c8011890b7',
  --               chat_url = '/v1/chat/completions',
  --             },
  --             schema = {
  --               model = {
  --                 default = current_model,
  --                 -- default = 'google/gemini-2.5-pro-preview-03-25',
  --                 -- default = 'google/gemini-2.5-flash-preview',
  --               },
  --             },
  --           })
  --         end,
  --       },
  --     }
  --     vim.keymap.set({ 'n', 'v' }, '<Leader>av', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true, desc = 'Toggle CodeCompanionChat' })
  --     vim.keymap.set({ 'n' }, '<Leader>am', select_model, { noremap = true, silent = true, desc = 'Select CodeCompanion [m]odel' })
  --   end,
  -- },
}
