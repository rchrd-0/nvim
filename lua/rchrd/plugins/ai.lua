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
}
