local M = {}

function M.get_servers()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local util = require 'lspconfig.util'

  local vue_language_server_path = vim.fn.expand '$MASON/packages' .. '/vue-language-server' .. '/node_modules/@vue/language-server'
  local vue_plugin = {
    name = '@vue/typescript-plugin',
    location = vue_language_server_path,
    languages = { 'vue' },
    configNamespace = 'typescript',
    enableForWorkspaceTypeScriptVersions = true,
  }

  local svelte_language_server_path = vim.fn.expand '$MASON/packages' .. '/svelte-language-server' .. '/node_modules/typescript-svelte-plugin'
  local svelte_plugin = {
    name = 'typescript-svelte-plugin',
    location = svelte_language_server_path,
    enableForWorkspaceTypeScriptVersions = true,
  }

  return {
    vtsls = {
      filetypes = { 'typescript', 'javascript', 'javascript.jsx', 'javascriptreact', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte' },
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
              vue_plugin,
              svelte_plugin,
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
        },
      },
    },
    html = {},
    emmet_language_server = {},
    cssls = {
      capabilities = capabilities,
      filetypes = { 'css', 'scss', 'less' },
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
    biome = {
      workspace_required = true,
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescript.tsx',
        'typescriptreact',
        -- 'astro',
        -- 'css',
        -- 'graphql',
        -- 'json',
        -- 'jsonc',
      },
      settings = {
        requireConfiguration = true,
      },
    },
  }
end

return M
