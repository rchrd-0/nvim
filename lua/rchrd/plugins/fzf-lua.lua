return {
  'ibhagwan/fzf-lua',
  dependencies = {
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- Call setup, passing any custom configuration tables
    require('fzf-lua').setup {
      -- Examples of configuration options:
      -- winopts = {
      --   height = 0.85,
      --   width = 0.80,
      --   row = 0.5,
      --   col = 0.5,
      --   border = { '╭', '─', '╮', '│', '╯', '─', '╰', '│' },
      -- },
      -- keymap = { -- fzf window specific keymaps
      --   ['fzf-bindings'] = {
      --     ['ctrl-j'] = 'down',
      --     ['ctrl-k'] = 'up',
      --   },
      -- },
      -- You can find more options in the fzf-lua documentation
      -- https://github.com/ibhagwan/fzf-lua/blob/main/README.md
    }

    -- === Define Keymaps using fzf-lua ===
    -- You can place these here, or in your separate keymaps.lua file
    -- making sure fzf-lua is required *before* the keymaps are set.
    -- If placing in keymaps.lua, ensure lazy loading loads fzf-lua first
    -- or use `vim.api.nvim_create_user_command` or wrap in functions.
    -- For simplicity, putting them here for now.

    local fzf = require 'fzf-lua' -- Optional: alias for brevity

    -- Note: Descriptions are updated for fzf-lua
    vim.keymap.set('n', '<leader>sh', fzf.help_tags, { desc = '[S]earch [H]elp (fzf)' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = '[S]earch [K]eymaps (fzf)' })
    vim.keymap.set('n', '<leader>sf', fzf.files, { desc = '[S]earch [F]iles (fzf)' })
    vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = '[S]earch [S]elect fzf action' }) -- Shows fzf-lua built-ins
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = '[S]earch current [W]ord (fzf)' })
    vim.keymap.set('n', '<leader>sg', fzf.live_grep, { desc = '[S]earch by [G]rep (fzf)' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = '[S]earch [D]iagnostics Document (fzf)' })
    vim.keymap.set('n', '<leader>sD', fzf.diagnostics_workspace, { desc = '[S]earch [D]iagnostics Workspace (fzf)' })
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = '[S]earch [R]esume (fzf)' })
    vim.keymap.set('n', '<leader>s.', fzf.oldfiles, { desc = '[S]earch Recent Files ("." for repeat) (fzf)' })
    vim.keymap.set('n', '<leader><leader>', fzf.buffers, { desc = '[ ] Find existing buffers (fzf)' })

    -- Fuzzy search in current buffer (blines is often preferred over current_buffer_fuzzy_find)
    vim.keymap.set('n', '<leader>/', fzf.blines, { desc = '[/] Fuzzily search in current buffer lines (fzf)' })
    -- If you prefer the file content search:
    -- vim.keymap.set('n', '<leader>/', fzf.current_buffer_fuzzy_find, { desc = '[/] Fuzzily search in current buffer content (fzf)' })

    -- Grep in open files
    vim.keymap.set('n', '<leader>s/', function()
      fzf.live_grep {
        grep_open_files = true,
        -- You might need to configure fzf-lua's grep command or ensure 'rg' is available
        -- prompt = 'Live Grep Open Files> ' -- Customize prompt if desired
      }
    end, { desc = '[S]earch [/] in Open Files (fzf)' })

    -- Search Neovim config files
    vim.keymap.set('n', '<leader>sn', function()
      fzf.files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[S]earch [N]eovim files (fzf)' })
  end,
}
