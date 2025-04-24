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
    'supermaven-inc/supermaven-nvim',
    enabled = false,
    config = function()
      require('supermaven-nvim').setup {
        disable_inline_completion = false,
        keymaps = {
          accept_suggestion = '<M-l>',
          accept_word = '<M-.>',
        },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    -- version = 'v3.3.0',
    build = 'make tiktoken',
    dependencies = {
      { 'nvim-telescope/telescope.nvim' }, -- telescope for help actions
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      debug = false,
      model = 'claude-3.7-sonnet',
      auto_follow_cursor = false,
      show_help = true,
      mappings = {
        -- Use tab for completion
        complete = {
          detail = 'Use @<Tab> or /<Tab> for options.',
          insert = '<Tab>',
        },
        -- Close the chat
        close = {
          normal = 'q',
          insert = '<C-c>',
        },
        -- Reset the chat buffer
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        -- Submit the prompt to Copilot
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-CR>',
          -- insert = '<C-M>',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      local select = require 'CopilotChat.select'
      -- Use unnamed register for the selection
      opts.selection = select.unnamed
      opts.prompts = {
        Explain = { prompt = 'Please explain how the following code works.' },
        Review = { prompt = 'Please review the following code and provide suggestions for improvement.' },
        Tests = { prompt = 'Please explain how the selected code works, then generate unit tests for it.' },
        Refactor = { prompt = 'Please refactor the following code to improve its clarity and readability.' },
        FixCode = { prompt = 'Please fix the following code to make it work as intended.' },
        FixError = { prompt = 'Please explain the error in the following text and provide a solution.' },
        BetterNamings = { prompt = 'Please provide better names for the following variables and functions.' },
        Documentation = { prompt = 'Please provide documentation for the following code.' },
        SwaggerApiDocs = { prompt = 'Please provide documentation for the following API using Swagger.' },
        SwaggerJsDocs = { prompt = 'Please write JSDoc for the following API using Swagger.' },
        -- Text related prompts
        Summarize = { prompt = 'Please summarize the following text.' },
        Spelling = { prompt = 'Please correct any grammar and spelling errors in the following text.' },
        Wording = { prompt = 'Please improve the grammar and wording of the following text.' },
        Concise = { prompt = 'Please rewrite the following text to make it more concise.' },
      }

      chat.setup(opts)
      -- -- Setup the CMP integration
      -- require('CopilotChat.integrations.cmp').setup()

      vim.api.nvim_create_user_command('CopilotChatVisual', function(args)
        chat.ask(args.args, { selection = select.visual })
      end, { nargs = '*', range = true })

      -- Inline chat with Copilot
      vim.api.nvim_create_user_command('CopilotChatInline', function(args)
        chat.ask(args.args, {
          selection = select.visual,
          window = {
            layout = 'float',
            relative = 'cursor',
            width = 1,
            height = 0.4,
            row = 1,
          },
        })
      end, { nargs = '*', range = true })

      -- Restore CopilotChatBuffer
      vim.api.nvim_create_user_command('CopilotChatBuffer', function(args)
        chat.ask(args.args, { selection = select.buffer })
      end, { nargs = '*', range = true })

      -- Custom buffer for CopilotChat
      vim.api.nvim_create_autocmd('BufEnter', {
        pattern = 'copilot-*',
        callback = function()
          vim.opt_local.relativenumber = true
          vim.opt_local.number = true

          -- Get current filetype and set it to markdown if the current filetype is copilot-chat
          local ft = vim.bo.filetype
          if ft == 'copilot-chat' then
            vim.bo.filetype = 'markdown'
          end
        end,
      })

      -- Add which-key mappings
      local wk = require 'which-key'
      wk.add {
        { '<leader>a', group = '+Copilot Chat' },
        { '<leader>gm', group = '+Copilot Chat' }, -- group
      }
    end,
    event = 'VeryLazy',
    keys = {
      -- Show help actions with telescope
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt {
            context = {
              'buffers',
            },
          }
        end,
        desc = 'CopilotChat - [P]rompt [a]ctions',
      },
      {
        '<leader>ap',
        function()
          require('CopilotChat').select_prompt()
        end,
        mode = 'x',
        desc = 'CopilotChat - [P]rompt [a]ctions',
      },
      -- Code related commands
      { '<leader>ae', '<cmd>CopilotChatExplain<cr>', desc = 'CopilotChat - [E]xplain code' },
      { '<leader>at', '<cmd>CopilotChatTests<cr>', desc = 'CopilotChat - Generate [t]ests' },
      { '<leader>ar', '<cmd>CopilotChatReview<cr>', desc = 'CopilotChat - [R]eview code' },
      { '<leader>aR', '<cmd>CopilotChatRefactor<cr>', desc = 'CopilotChat - [R]efactor code' },
      { '<leader>an', '<cmd>CopilotChatBetterNamings<cr>', desc = 'CopilotChat - Better [N]aming' },
      -- Chat with Copilot in visual mode
      {
        '<leader>av',
        ':CopilotChatVisual<cr>',
        mode = 'x',
        desc = 'CopilotChat - Open in [v]ertical split',
        silent = true,
      },
      {
        '<leader>ax',
        ':CopilotChatInline<cr>',
        mode = 'x',
        desc = 'CopilotChat - Inline chat',
        silent = true,
      },
      -- Custom input for CopilotChat
      {
        '<leader>ai',
        function()
          local input = vim.fn.input 'Ask Copilot: '
          if input ~= '' then
            vim.cmd('CopilotChat ' .. input)
          end
        end,
        desc = 'CopilotChat - Ask [i]nput',
      },
      -- Generate commit message based on the git diff
      {
        '<leader>am',
        '<cmd>CopilotChatCommit<cr>',
        desc = 'CopilotChat - Generate commit [m]essage for all changes',
      },
      -- Quick chat with Copilot
      {
        '<leader>aq',
        function()
          local input = vim.fn.input 'Quick Chat: '
          if input ~= '' then
            vim.cmd('CopilotChatBuffer ' .. input)
          end
        end,
        desc = 'CopilotChat - Quick chat',
      },
      -- Fix the issue with diagnostic
      { '<leader>af', '<cmd>CopilotChatFix<cr>', desc = 'CopilotChat - [F]ix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      -- Copilot Chat Models
      { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    },
  },
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    -- config = function()
    -- end,
    opts = {
      strategies = {
        chat = {
          adapter = 'openrouter',
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
