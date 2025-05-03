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
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      local default_model = 'google/gemini-2.5-pro-preview-03-25'
      local available_models = {
        'google/gemini-2.5-pro-preview-03-25',
        'google/gemini-2.5-flash-preview',
        'google/gemini-2.5-flash-preview:thinking',
        'anthropic/claude-3.7-sonnet',
        'anthropic/claude-3.7-sonnet:thinking',
        'anthropic/claude-3.5-sonnet',
        'openai/gpt-4.1',
        'openai/gpt-4.1-mini',
        'openai/gpt-4.1-nano',
        'openai/gpt-4o-mini',
      }
      local current_model = default_model

      local function select_model()
        vim.ui.select(available_models, {
          prompt = 'Select  Model:',
        }, function(choice)
          if choice then
            current_model = choice
            vim.notify('Selected model: ' .. current_model)
          end
        end)
      end

      require('codecompanion').setup {
        strategies = {
          chat = {
            adapter = 'openrouter',
            slash_commands = {
              ['file'] = {
                callback = 'strategies.chat.slash_commands.file',
                description = 'Select file(s)',
                opts = {
                  provider = 'mini_pick',
                  contains_code = true,
                },
              },
              ['buffer'] = {
                callback = 'strategies.chat.slash_commands.buffer',
                description = 'Select buffer(s)',
                opts = {
                  provider = 'mini_pick',
                  contains_code = true,
                },
              },
              ['help'] = {
                callback = 'strategies.chat.slash_commands.help',
                description = 'Select helpfile(s)',
                opts = {
                  provider = 'mini_pick',
                  contains_code = true,
                },
              },
            },
            keymaps = {
              send = {
                modes = { i = '<C-CR>' },
              },
            },
          },
          inline = {
            adapter = 'openrouter',
          },
        },
        default = {
          keymaps = {
            send = {
              modes = { i = '<C-CR>' },
            },
          },
        },
        adapters = {
          copilot = function()
            return require('codecompanion.adapters').extend('copilot', {
              schema = {
                model = {
                  default = 'claude-3.7-sonnet',
                },
              },
            })
          end,
          openrouter = function()
            return require('codecompanion.adapters').extend('openai_compatible', {
              env = {
                url = 'https://openrouter.ai/api',
                api_key = 'cmd:bw get password 1772c482-a837-407d-8888-b2c8011890b7',
                chat_url = '/v1/chat/completions',
              },
              schema = {
                model = {
                  default = current_model,
                  -- default = 'google/gemini-2.5-pro-preview-03-25',
                  -- default = 'google/gemini-2.5-flash-preview',
                },
              },
            })
          end,
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<Leader>av', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true, desc = 'Toggle CodeCompanionChat' })
      vim.keymap.set({ 'n' }, '<Leader>am', select_model, { noremap = true, silent = true, desc = 'Select CodeCompanion [m]odel' })
    end,
  },
}
