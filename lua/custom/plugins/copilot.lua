return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    event = 'InsertEnter',
    build = ':Copilot auth',
    opts = {
      suggestion = {
        auto_trigger = true,
      },
    },
  },
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    branch = 'canary',
    dependencies = {
      { 'zbirenbaum/copilot.lua' }, -- or github/copilot.vim
      { 'nvim-lua/plenary.nvim' }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      model = 'gpt-4o',
      buffers = 'buffers',

      window = {
        width = 0.5,
      },
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },

  vim.api.nvim_set_keymap('n', '<leader>cct', ':CopilotChatToggle<CR>', { desc = '[C]opilot [C]hat [T]oggle', noremap = true, silent = true }),
  vim.keymap.set('n', '<leader>ccq', function()
    local input = vim.fn.input 'Quick Chat: '
    if input ~= '' then
      require('CopilotChat').ask(input, { selection = require('CopilotChat.select').buffer })
    end
  end, { desc = '[C]opilot [C]hat [Q]uick' }),
}
