local M = {}

function M.get_servers(mason_registry)
  local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
  local svelte_language_server_path = mason_registry.get_package('svelte-language-server'):get_install_path() .. '/node_modules/typescript-svelte-plugin'

  return {
    vtsls = {
      -- tsserver = {
      --   globalPlugins = {
      --     {
      --       name = '@vue/typescript-plugin',
      --       location = vue_language_server_path,
      --       languages = { 'vue' },
      --       configNamespace = 'typescript',
      --       enableForWorkspaceTypeScriptVersions = true,
      --     },
      --     {
      --       name = 'typescript-svelte-plugin',
      --       location = svelte_language_server_path,
      --       enableForWorkspaceTypeScriptVersions = true,
      --     },
      --   },
      -- },
      filetypes = { 'typescript', 'javascript', 'javascript.jsx', 'javascriptreact', 'typescriptreact', 'javascript.jsx', 'typescript.tsx', 'vue' },
      settings = {
        complete_function_calls = true,
        implicitProjectConfiguration = {
          checkJs = false,
        },
        vtsls = {
          enableMoveToFileCodeAction = true,
          autoUseWorkspaceTsdk = true,
          experimental = {
            maxInlayHintLength = 30,
            completion = {
              enableServerSideFuzzyMatch = true,
            },
          },
          tsserver = {
            globalPlugins = {
              {
                name = '@vue/typescript-plugin',
                location = vue_language_server_path,
                languages = { 'vue' },
                configNamespace = 'typescript',
                enableForWorkspaceTypeScriptVersions = true,
              },
              {
                name = 'typescript-svelte-plugin',
                location = svelte_language_server_path,
                enableForWorkspaceTypeScriptVersions = true,
              },
            },
          },
        },
        typescript = {
          updateImportsOnFileMove = { enabled = 'always' },
          suggest = {
            completeFunctionCalls = true,
          },
          -- referencesCodeLens = { enabled = true, showOnAllFunctions = true },
          -- implementationsCodeLens = { enabled = true, showOnInterfaceMethods = true },
          inlayHints = {
            enumMemberValues = { enabled = true },
            functionLikeReturnTypes = { enabled = true },
            parameterNames = { enabled = 'all', suppressWhenArgumentMatchesName = true },
            parameterTypes = { enabled = true },
            propertyDeclarationTypes = { enabled = true },
            variableTypes = { enabled = false },
          },
          preferences = {
            useAliasesForRenames = false,
            importModuleSpecifier = 'non-relative',
          },
          -- inlayHints = {
          --   includeInlayParameterNameHints = 'all', -- 'none' | 'literals' | 'all'
          --   includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          --   includeInlayVariableTypeHints = false,
          --   includeInlayFunctionParameterTypeHints = false,
          --   includeInlayVariableTypeHintsWhenTypeMatchesName = true,
          --   includeInlayPropertyDeclarationTypeHints = false,
          --   includeInlayFunctionLikeReturnTypeHints = false,
          --   includeInlayEnumMemberValueHints = true,
          -- },
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
    volar = {
      -- init_options = {
      --   vue = {
      --     hybridMode = true,
      --   },
      -- },
    },
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
