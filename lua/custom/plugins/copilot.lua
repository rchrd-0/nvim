return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        enabled = false,
        auto_trigger = false,
        keymap = {
          accept = '<M-l>',
          accept_word = '<M-.>',
          accept_line = false,
          next = '<M-]>',
          prev = '<M-[>',
          dismiss = '<C-]>',
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
    config = function()
      require('supermaven-nvim').setup {
        -- disable_inline_completion = true,
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
      debug = true,
      model = 'claude-3.5-sonnet',
      auto_follow_cursor = false,
      show_help = true,
      mappings = {
        submit_prompt = {
          normal = '<CR>',
          insert = '<C-M>',
        },
        reset = {
          normal = '<C-x>',
          insert = '<C-x>',
        },
        accept_diff = {
          normal = '<C-y>',
          insert = '<C-y>',
        },
        yank_diff = {
          normal = 'gmy',
        },
        show_diff = {
          normal = 'gmd',
        },
        show_info = {
          normal = 'gmp',
        },
        show_context = {
          normal = 'gms',
        },
      },
    },
    config = function(_, opts)
      local chat = require 'CopilotChat'
      local select = require 'CopilotChat.select'
      -- Use unnamed register for the selection
      opts.selection = select.unnamed

      -- Override the git prompts message
      -- opts.prompts.Commit = {
      --   prompt = 'Write commit message for the change with commitizen convention',
      --   selection = select.gitdiff,
      -- }
      -- opts.prompts.CommitStaged = {
      --   prompt = 'Write commit message for the change with commitizen convention',
      --   selection = function(source)
      --     return select.gitdiff(source, true)
      --   end,
      -- }
      opts.prompts = {
        Refactor = {
          prompt = '/COPILOT_GENERATE Please refactor the following code to improve its clarity and readability.',
        },
        BetterNamings = {
          prompt = '/COPILOT_GENERATE Please provide better names for the following variables and functions.',
        },
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
        { '<leader>gmd', desc = 'Show [d]iff' },
        { '<leader>gmp', desc = 'System [p]rompt' },
        { '<leader>gms', desc = 'Show [s]election' },
        { '<leader>gmy', desc = '[Y]ank diff' },
      }
    end,
    event = 'VeryLazy',
    keys = {
      -- Show help actions with telescope
      {
        '<leader>ah',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.help_actions())
        end,
        desc = 'CopilotChat - Help actions',
      },
      -- Show prompts actions with telescope
      {
        '<leader>ap',
        function()
          local actions = require 'CopilotChat.actions'
          require('CopilotChat.integrations.telescope').pick(actions.prompt_actions())
        end,
        desc = 'CopilotChat - [P]rompt [a]ctions',
      },
      {
        '<leader>ap',
        ":lua require('CopilotChat.integrations.telescope').pick(require('CopilotChat.actions').prompt_actions({selection = require('CopilotChat.select').visual}))<CR>",
        mode = 'x',
        desc = 'CopilotChat - [P]rompt [a]ctions',
        silent = true,
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
      {
        '<leader>aM',
        '<cmd>CopilotChatCommitStaged<cr>',
        desc = 'CopilotChat - Generate commit [m]essage for staged changes',
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
      -- Debug
      { '<leader>ad', '<cmd>CopilotChatDebugInfo<cr>', desc = 'CopilotChat - [D]ebug Info' },
      -- Fix the issue with diagnostic
      { '<leader>af', '<cmd>CopilotChatFixDiagnostic<cr>', desc = 'CopilotChat - [F]ix Diagnostic' },
      -- Clear buffer and chat history
      { '<leader>al', '<cmd>CopilotChatReset<cr>', desc = 'CopilotChat - Clear buffer and chat history' },
      -- Toggle Copilot Chat Vsplit
      { '<leader>av', '<cmd>CopilotChatToggle<cr>', desc = 'CopilotChat - Toggle' },
      -- Copilot Chat Models
      { '<leader>a?', '<cmd>CopilotChatModels<cr>', desc = 'CopilotChat - Select Models' },
    },
  },
}
