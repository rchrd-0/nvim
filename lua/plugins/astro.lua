return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {
          on_attach = function(client)
            -- Astro's formatter uses Prettier defaults when no project config exists.
            -- Keep formatting in Conform so its config requirement always applies.
            client.server_capabilities.documentFormattingProvider = false
            client.server_capabilities.documentRangeFormattingProvider = false
          end,
        },
      },
    },
  },
}
