if vim.g.vscode then
  require 'custom.vscode'
  return
end

--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.mouse = 'a'
vim.api.nvim_command 'aunmenu PopUp.How-to\\ disable\\ mouse'
vim.api.nvim_command 'aunmenu PopUp.-1-'

vim.opt.showmode = false
-- vim.opt.clipboard = 'unnamedplus'
vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = 'yes'
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
-- vim.opt.listchars = { tab = '· ', trail = '·', nbsp = '␣' }
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.colorcolumn = '80,100'
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.autoread = true

vim.opt.wildmode = 'longest:full,full'
vim.opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp', 'folds' }

local keymaps = require 'custom.keymaps'
for _, keymap in ipairs(keymaps) do
  vim.keymap.set(keymap[1], keymap[2], keymap[3], keymap[4])
end

vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- save folds
vim.cmd [[
  augroup remember_folds
      autocmd!
      autocmd BufWinLeave *.* mkview
      autocmd BufWinEnter *.* silent! loadview
    augroup END
  ]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- local function use_prettierd()
--   local root = vim.fn.getcwd()
--   local no_prettierd_marker = root .. '/.no-prettierd'
--   return vim.fn.filereadable(no_prettierd_marker) ~= 1
-- end

require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  {
    'numToStr/Comment.nvim',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('Comment').setup {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
    opts = {},
    lazy = false,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
  },
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },
  { -- Fuzzy Finder (files, lsp, etc)
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    config = function()
      -- :Telescope help_tags
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      --
      require('telescope').setup {
        defaults = {
          file_ignore_patterns = { '.git/', 'node_modules/' },
          mappings = {
            i = {
              -- ['<c-enter>'] = 'to_fuzzy_refine',
              ['<C-h>'] = 'which_key',
            },
          },
        },
        pickers = {
          find_files = {
            hidden = true,
            -- no_ignore = true,
            follow = true,
          },
          live_grep = {
            file_ignore_patterns = {
              '%.lock$',
              '%-lock%..*$',
              '.git/',
              'node_modules/',
            },
            additional_args = { '--hidden' },
          },
          buffers = {
            mappings = {
              i = {
                ['<C-x>'] = require('telescope.actions').delete_buffer,
              },
              n = {
                ['<C-x>'] = require('telescope.actions').delete_buffer,
              },
            },
          },
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
      vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
      vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
      vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
      vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
      vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
      vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
      vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
      vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to Telescope to change the theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = true,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- It's also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[S]earch [/] in Open Files' })

      -- Shortcut for searching your Neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[S]earch [N]eovim files' })
    end,
  },

  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for Neovim
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },
    opts = {
      inlay_hints = { enabled = true },
    },
    config = function()
      local lspconfig = require 'lspconfig'
      lspconfig.sourcekit.setup {
        filetypes = { 'objc', 'swift' },
        cmd = { '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp' },
      }
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end

          -- Jump to the definition of the word under your cursor.
          --  This is where a variable was first declared, or where a function is defined, etc.
          --  To jump back, press <C-t>.
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

          -- Find references for the word under your cursor.
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

          -- Jump to the implementation of the word under your cursor.
          --  Useful when your language has ways of declaring types without an actual implementation.
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

          -- Jump to the type of the word under your cursor.
          --  Useful when you're not sure what type a variable is and you want to see
          --  the definition of its *type*, not where it was *defined*.
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

          -- Fuzzy find all the symbols in your current workspace.
          --  Similar to document symbols, except searches over your entire project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

          -- Rename the variable under your cursor.
          --  Most Language Servers support renaming across files, etc.
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

          -- Execute a code action, usually your cursor needs to be on top of an error
          -- or a suggestion from your LSP for this to activate.
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

          -- Opens a popup that displays documentation about the word under your cursor
          --  See `:help K` for why this keymap.
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- WARN: This is not Goto Definition, this is Goto Declaration.
          --  For example, in C this would take you to the header.
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- The following autocommand is used to enable inlay hints in your
          -- code, if the language server you are using supports them
          --
          -- This may be unwanted, since they displace some of your code
          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      vim.api.nvim_create_autocmd('LspDetach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
        callback = function(event)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event.buf }
        end,
      })
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      local mason_registry = require 'mason-registry'
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'

      local servers = {
        -- general web dev
        ts_ls = {
          init_options = {
            plugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
              },
            },
          },
          filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
          settings = {
            implicitProjectConfiguration = {
              checkJs = false,
            },
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayVariableTypeHints = false,
                includeInlayFunctionParameterTypeHints = false,
                includeInlayVariableTypeHintsWhenTypeMatchesName = true,
                includeInlayPropertyDeclarationTypeHints = false,
                includeInlayFunctionLikeReturnTypeHints = false,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        html = {
          filetypes = { 'html', 'ejs' },
          init_options = {
            -- provideFormatter = false,
          },
        },
        astro = {},
        emmet_language_server = {
          filetypes = {
            'html',
            'javascript',
            'javascriptreact',
            'typescriptreact',
            'css',
            'sass',
            'scss',
            'ejs',
            'vue',
            'blade',
          },
        },
        cssls = {
          -- filetypes = { 'html', 'css', 'scss', 'vue', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'svelte' },
          settings = {
            css = { validate = true, lint = { unknownAtRules = 'ignore' } },
            scss = { validate = true, lint = { unknownAtRules = 'ignore' } },
          },
        },
        tailwindcss = {
          filetypes = { 'html', 'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'vue', 'svelte', 'astro', 'css' },
          settings = {
            tailwindCSS = {
              classAttributes = { 'class', 'className', 'class:list', 'classList', 'ngClass', '.*ClassName' },
            },
          },
        },
        eslint = {},
        prettierd = {},
        volar = {},
        -- biome = {},

        -- go
        gopls = {},

        -- php
        phpactor = {},
        intelephense = {},

        -- python
        pyright = {},
        ruff = {},

        -- crypto
        solidity_ls_nomicfoundation = {},

        clangd = {},
        taplo = {},
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },
      }
      require('mason').setup()

      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, {
        'stylua', -- Used to format Lua code
        'ruff',
      })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      require('mason-lspconfig').setup {
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },

  { -- Autoformat
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
      {
        '<leader>uf',
        function()
          vim.g.disable_autoformat = not vim.g.disable_autoformat
          print('Global autoformatting ' .. (vim.g.disable_autoformat and 'disabled' or 'enabled'))
        end,
        mode = 'n',
        desc = 'Toggle Auto Format (Global)',
      },
      {
        '<leader>uF',
        function()
          vim.b.disable_autoformat = not vim.b.disable_autoformat
          print('Buffer autoformatting ' .. (vim.b.disable_autoformat and 'disabled' or 'enabled'))
        end,
        mode = 'n',
        desc = 'Toggle Auto Format (Buffer)',
      },
      -- {
      --   '<leader>ufs',
      --   function()
      --     local global_status = vim.g.disable_autoformat and 'disabled' or 'enabled'
      --     local buffer_status = vim.b.disable_autoformat and 'disabled' or 'enabled'
      --     print(string.format('Global autoformatting: %s', global_status))
      --     print(string.format('Buffer autoformatting: %s', buffer_status))
      --   end,
      --   mode = 'n',
      --   desc = 'Show Auto Format Status',
      -- },
    },
    vim.api.nvim_create_user_command('FormatDisable', function(args)
      if args.bang then
        -- FormatDisable! will disable formatting just for this buffer
        vim.b.disable_autoformat = true
      else
        vim.g.disable_autoformat = true
      end
    end, {
      desc = 'Disable autoformat-on-save',
      bang = true,
    }),
    vim.api.nvim_create_user_command('FormatEnable', function()
      vim.b.disable_autoformat = false
      vim.g.disable_autoformat = false
    end, {
      desc = 'Re-enable autoformat-on-save',
    }),
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        local disable_filetypes = { c = true, cpp = true }
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        swift = { 'swiftformat' },
        python = {
          'ruff_fix',
          'ruff_format',
        },
        html = {
          'prettierd',
        },
        css = {
          'prettierd',
        },
        javascript = { 'prettierd', stop_after_first = true },
        typescript = { 'prettierd', stop_after_first = true },
        javascriptreact = { 'prettierd', stop_after_first = true },
        typescriptreact = { 'prettierd', stop_after_first = true },
        vue = { 'prettierd', stop_after_first = true },
        astro = { 'prettierd', stop_after_first = true },
        -- css = { 'prettierd', 'prettier', stop_after_first = true },
        -- javascriptreact = function()
        --   return use_prettierd() and { 'prettierd', 'prettier' } or { 'prettier' }
        -- end,
        -- typescriptreact = function()
        --   return use_prettierd() and { 'prettierd', 'prettier' } or { 'prettier' }
        -- end,
        -- typescriptreact = { 'prettier', stop_after_first = true },
      },
      formatters = {
        ruff_fix = {
          command = 'ruff',
          args = {
            'check',
            '--fix',
            '--exit-zero',
            '--config',
            vim.fn.expand '~/.config/nvim/.ruff.toml', -- Adjust this path as needed
            '--stdin-filename',
            '$FILENAME',
            '-',
          },
          stdin = true,
        },
        ruff_format = {
          command = 'ruff',
          args = {
            'format',
            '--config',
            vim.fn.expand '~/.config/nvim/.ruff.toml', -- Adjust this path as needed
            '-',
          },
          stdin = true,
        },
        prettierd = {
          env = {
            PRETTIERD_DEFAULT_CONFIG = vim.fn.expand '~/.config/nvim/.prettierrc.json',
          },
        },
      },
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      {
        'L3MON4D3/LuaSnip',
        build = (function()
          if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
            return
          end
          return 'make install_jsregexp'
        end)(),
        dependencies = {
          {
            'rafamadriz/friendly-snippets',
            config = function()
              require('luasnip.loaders.from_vscode').lazy_load()
            end,
          },
        },
      },
      'saadparwaiz1/cmp_luasnip',

      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
    },
    config = function()
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'
      luasnip.config.setup {}
      luasnip.filetype_extend('javascript', { 'javascriptreact' })

      vim.filetype.add { extension = { ejs = 'ejs' } }
      luasnip.filetype_set('ejs', { 'html', 'javascript', 'ejs' })

      local function copilot_chat_active()
        local current_buf = vim.api.nvim_get_current_buf()
        local buf_name = vim.api.nvim_buf_get_name(current_buf)
        local buf_ft = vim.bo[current_buf].filetype

        -- Check if the buffer name starts with 'copilot-' or the filetype is 'copilot-chat'
        return string.match(buf_name, '^copilot%-') ~= nil or buf_ft == 'copilot-chat'
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        completion = { completeopt = 'menu,menuone,noinsert' },

        mapping = cmp.mapping.preset.insert {
          -- Select the [n]ext item
          ['<C-n>'] = cmp.mapping.select_next_item(),
          -- Select the [p]revious item
          ['<C-p>'] = cmp.mapping.select_prev_item(),

          -- Scroll the documentation window [b]ack / [f]orward
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),

          ['<C-y>'] = cmp.mapping.confirm { select = true },

          ['<C-Space>'] = cmp.mapping.complete {},

          ['<Tab>'] = cmp.mapping(function(fallback)
            if copilot_chat_active() then
              fallback()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function()
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
          -- { name = 'supermaven' },
        },
      }
    end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = true } },

  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup { n_lines = 500 }
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = vim.g.have_nerd_font }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end
    end,
  },
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    opts = {
      ensure_installed = { 'bash', 'c', 'html', 'lua', 'luadoc', 'markdown', 'vim', 'vimdoc', 'vue', 'css', 'scss', 'php', 'go', 'jsdoc', 'javascript' },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'ruby' },
        injection_queries = {
          ['html'] = [=[
          ((attribute
            (attribute_name) @_attr
            (quoted_attribute_value
              (attribute_value) @javascript))
            (#match? @_attr "^x-.*$"))
          ((attribute
            (attribute_name) @_attr
            (quoted_attribute_value
              (attribute_value) @javascript))
            (#match? @_attr "^:.*$"))
          ((attribute
            (attribute_name) @_attr
            (quoted_attribute_value
              (attribute_value) @javascript))
            (#match? @_attr "^@.*$"))
        ]=],
        },
      },
      indent = { enable = true, disable = { 'ruby' } },
      -- autotag = {
      --   filetypes = {
      --     'html',
      --     'vue',
      --     'svelte',
      --   },
      --   enable = true,
      --   enable_rename = true,
      --   enable_close = true,
      --   enable_close_on_slash = true,
      -- },
    },
    config = function(_, opts)
      require('nvim-treesitter.install').prefer_git = true
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup(opts)

      -- vim.treesitter.language.register('html', 'ejs')
      -- vim.treesitter.language.register('javascript', 'ejs')

      vim.filetype.add {
        pattern = {
          ['.env.*'] = 'bash',
        },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- NOTE: Next step on your Neovim journey: Add/Configure additional plugins for Kickstart
  --
  -- require 'kickstart.plugins.debug',
  -- require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  require 'kickstart.plugins.gitsigns', -- adds gitsigns recommend keymaps

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    This is the easiest way to modularize your config.
  --
  { import = 'custom.plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
      diagnostics = {
        Error = ' ',
        Warn = ' ',
        Hint = ' ',
        Info = ' ',
      },
    },
  },
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
