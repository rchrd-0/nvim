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
    init = function()
      vim.keymap.set({ 'n', 'v' }, '<Leader>av', ':CodeCompanionChat Toggle<CR>', { noremap = true, silent = true })
    end,
    opts = {
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
                default = 'google/gemini-2.5-pro-preview-03-25',
                -- default = 'google/gemini-2.5-flash-preview',
              },
            },
          })
        end,
      },
    },
  },
}
