return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.extra').setup()

    local pick = require 'mini.pick'
    local win_config = function()
      local height = math.floor(0.618 * vim.o.lines)
      local width = math.floor(0.618 * vim.o.columns)
      return {
        anchor = 'NW',
        height = height,
        width = width,
        row = math.floor(0.5 * (vim.o.lines - height)),
        col = math.floor(0.5 * (vim.o.columns - width)),
      }
    end
    pick.setup {
      window = {
        config = win_config,
      },
    }

    vim.ui.select = MiniPick.ui_select

    vim.keymap.set('n', '<leader>sf', ':Pick files<CR>', { desc = '[S]earch [F]iles', silent = true })
    vim.keymap.set('n', '<leader><leader>', ':Pick buffers<CR>', { desc = '[ ] Find existing buffers', silent = true })
    vim.keymap.set('n', '<leader>sg', ':Pick grep_live<CR>', { desc = '[S]earch by [G]rep', silent = true })
    vim.keymap.set('n', '<leader>sw', ":Pick grep pattern='<cword>'<CR>", { desc = '[S]earch current [W]ord', silent = true })
    vim.keymap.set('n', '<leader>sr', ':Pick resume<CR>', { desc = '[S]earch [R]esume', silent = true })
    vim.keymap.set('n', '<leader>sT', ":Pick grep pattern='(TODO|FIXME|HACK|NOTE|DEV):'<CR>", { desc = '[S]earch [T]odo', silent = true })

    vim.keymap.set('n', '<leader>sh', ':Pick help<CR>', { desc = '[S]earch [H]elp (mini.pick)', silent = true })
    vim.keymap.set('n', '<leader>sk', ':Pick keymaps<CR>', { desc = '[S]earch [K]eymaps (mini.extra)', silent = true })
    vim.keymap.set('n', '<leader>sD', ':Pick commands<CR>', { desc = '[S]earch [D]iagnostics Workspace' })
    vim.keymap.set('n', '<leader>sd', ":Pick diagnostic scope='current'<CR>", { desc = '[S]earch [D]iagnostics Document' })
    vim.keymap.set('n', '<leader>sD', ":Pick diagnostic scope='all'<CR>", { desc = '[S]earch [D]iagnostics Workspace' })
    vim.keymap.set('n', '<leader>sy', ':Pick registers<CR>', { desc = '[S]earch [Y]ank Registers' })
    vim.keymap.set('n', '<leader>/', ":Pick buf_lines scope='current'<CR>", { desc = '[/] Fuzzily search in current buffer' })
    vim.keymap.set('n', '<leader>s/', ":Pick buf_lines scope='all'<CR>", { desc = '[S]earch [/] in Open Files' })
    vim.keymap.set('n', '<leader>s.', ':Pick oldfiles<CR>', { desc = '[S]earch Recent Files ("." for repeat)', silent = true })

    -- lsp
    vim.keymap.set('n', 'grr', ":Pick lsp scope='references'<CR>", { desc = 'LSP: [G]oto [R]eferences', silent = true })
    vim.keymap.set('n', 'gri', ":Pick lsp scope='implementation'<CR>", { desc = 'LSP: [G]oto [I]mplementation', silent = true })
    vim.keymap.set('n', 'grd', ":Pick lsp scope='definition'<CR>", { desc = 'LSP: [G]oto [D]efinition', silent = true })
    vim.keymap.set('n', 'g0', ":Pick lsp scope='document_symbol'<CR>", { desc = 'LSP: Open Document Symbols', silent = true })
    vim.keymap.set('n', 'gW', ":Pick lsp scope='workspace_symbol'<CR>", { desc = 'LSP: Open [W]orkspace Symbols', silent = true })
    vim.keymap.set('n', 'grt', ":Pick lsp scope='type_definition'<CR>", { desc = 'LSP: Open [T]ype Definition', silent = true })

    -- vim.keymap.set('n', '<leader>ss', ':Pick builtins<CR>', { desc = '[S]earch [S]elect mini.pick action', silent = true })
    -- vim.keymap.set('n', '<leader>sw', ':Pick grep_live<CR>', { desc = '[S]earch current [W]ord (mini.pick - use visual select)', silent = true }) -- May need visual selection
    -- vim.keymap.set('n', '<leader>sn', ":Pick files { cwd = vim.fn.stdpath 'config' , silent = true}<CR>", { desc = '[S]earch [N]eovim files (mini.pick)' })

    local ai = require 'mini.ai'
    ai.setup {
      n_lines = 500,
      custom_textobjects = {
        o = ai.gen_spec.treesitter { -- code block
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
        f = ai.gen_spec.treesitter { a = '@function.outer', i = '@function.inner' }, -- function
        c = ai.gen_spec.treesitter { a = '@class.outer', i = '@class.inner' }, -- class
        t = { '<([%p%w]-)%f[^<%w][^<>]->.-</%1>', '^<.->().*()</[^/]->$' }, -- tags
        d = { '%f[%d]%d+' }, -- digits
        e = { -- Word with case
          { '%u[%l%d]+%f[^%l%d]', '%f[%S][%l%d]+%f[^%l%d]', '%f[%P][%l%d]+%f[^%l%d]', '^[%l%d]+%f[^%l%d]' },
          '^().*()$',
        },
        u = ai.gen_spec.function_call(), -- u for "Usage"
        U = ai.gen_spec.function_call { name_pattern = '[%w_]' }, -- without dot in function name
      },
    }

    require('mini.surround').setup {
      mappings = {
        add = 'gsa', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      },
    }

    require('mini.pairs').setup {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { 'string' },
      skip_unbalanced = true,
      markdown = true,
    }

    require('mini.move').setup {
      mappings = {
        left = '',
        right = '',
        down = 'J',
        up = 'K',

        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
    }

    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end
  end,
}
