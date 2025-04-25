local M = {}

function M.get_servers(mason_registry)
  local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path()
    .. '/node_modules/@vue/language-server'

  return {
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
          classFunctions = { 'cn', 'clsx', 'cva' },
        },
      },
    },
    eslint = {},
    prettierd = {},
    volar = {},
    biome = {
      filetypes = {
        'astro',
        'css',
        'graphql',
        'javascript',
        'javascriptreact',
        'json',
        'jsonc',
        'svelte',
        'typescript',
        'typescript.tsx',
        'typescriptreact',
        'vue',
      },
    },
  }
end

return M 