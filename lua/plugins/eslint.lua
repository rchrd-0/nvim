return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      setup = {
        eslint = function()
          if vim.g.lazyvim_eslint_auto_format == false then
            return
          end

          LazyVim.format.register(LazyVim.lsp.formatter({
            name = "ESLint fixes",
            primary = false,
            priority = 250, -- Apply lint fixes before Oxfmt/Conform formats the result.
            filter = "eslint",
            format = function(bufnr)
              -- Call ESLint directly so Conform cannot substitute the primary formatter.
              vim.api.nvim_buf_call(bufnr, function()
                vim.lsp.buf.format({ bufnr = bufnr, name = "eslint", timeout_ms = 5000 })
              end)
            end,
          }))
        end,
      },
    },
  },
}
