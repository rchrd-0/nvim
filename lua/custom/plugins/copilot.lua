return {
  -- {
  --   'zbirenbaum/copilot.lua',
  --   cmd = 'Copilot',
  --   event = 'InsertEnter',
  --   build = ':Copilot auth',
  --   opts = {
  --     suggestion = {
  --       auto_trigger = true,
  --       keymap = {
  --         accept = '<M-l>',
  --         accept_word = false,
  --         accept_line = false,
  --         next = '<M-]>',
  --         prev = '<M-[>',
  --         dismiss = '<C-]>',
  --       },
  --     },
  --   },
  -- },
  {
    'supermaven-inc/supermaven-nvim',
    config = function()
      require('supermaven-nvim').setup {
        keymaps = {
          accept_suggestion = '<M-l>',
          accept_word = '<M-.>',
        },
      }
    end,
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' },
      { 'nvim-lua/plenary.nvim' },
    },
    opts = {
      debug = true,
      model = 'gpt-4o',
      buffers = 'buffers',

      window = {
        width = 0.5,
      },
    },
  },

  vim.api.nvim_set_keymap('n', '<leader>cct', ':CopilotChatToggle<CR>', { desc = '[C]opilot [C]hat [T]oggle', noremap = true, silent = true }),
  vim.keymap.set('n', '<leader>ccq', function()
    local input = vim.fn.input 'Quick Chat: '
    if input ~= '' then
      require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
    end
  end, { desc = '[C]opilot [C]hat [Q]uick' }),
}
