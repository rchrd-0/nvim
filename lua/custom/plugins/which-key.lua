return { -- Useful plugin to show you pending keybinds.
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').add {
      { '<leader>c', group = '[C]ode' },
      { '<leader>d', group = '[D]ocument' },
      { '<leader>r', group = '[R]ename' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>w', group = '[W]orkspace' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      { '<C-W>H', desc = 'Move window left' },
      { '<C-W>J', desc = 'Move window down' },
      { '<C-W>K', desc = 'Move window up' },
      { '<C-W>L', desc = 'Move window right' },
      { '<leader>js', group = '[JS]Doc' },
      { '<leader>jsd', desc = 'Toggle [JSD]oc' },
      { '<leader>jss', desc = '[S]tart [JS]Doc checking' },
      { '<leader>jse', desc = '[E]nd [JSD]oc checking' },
      { '<leader>cc', group = '[Copilot] [C]hat' },
    }
  end,
}
