return {
  {
    "stevearc/conform.nvim",
    ---@param opts conform.setupOpts
    opts = function(_, opts)
      for _, ft in ipairs({
        "css",
        "graphql",
        "javascript",
        "javascriptreact",
        "jsonc",
        "scss",
        "typescript",
        "typescriptreact",
      }) do
        opts.formatters_by_ft[ft] = { "biome-check", "prettier", stop_after_first = true }
      end
      opts.formatters_by_ft.astro = { "biome-check", "prettier", stop_after_first = true }
      opts.formatters_by_ft.vue = { "biome", "prettier", stop_after_first = true }
      opts.formatters_by_ft.svelte = { "biome-check", "prettier", stop_after_first = true }
      opts.formatters_by_ft.json = { "biome-check", "prettier", "jsonls", stop_after_first = true }
      opts.formatters_by_ft.lua = { "stylua" }

      -- Prefer the daemon for each Prettier route, retaining the CLI if it is unavailable.
      for _, formatters in pairs(opts.formatters_by_ft) do
        if type(formatters) == "table" then
          for index, name in ipairs(formatters) do
            if name == "prettier" then
              table.insert(formatters, index, "prettierd")
              formatters.stop_after_first = true
              break
            end
          end
        end
      end

      -- Let each project choose its SQL dialect in .sqlfluff.
      opts.formatters.sqlfluff = { args = { "format", "-" } }

      opts.formatters.prettierd = { require_cwd = true }
      opts.formatters.biome = { require_cwd = true }
      opts.formatters["biome-check"] = { require_cwd = true }
      opts.formatters.prettier = {
        require_cwd = true,
        -- Conform finds actual config files/package.json fields and prefers the project-local binary.
        -- Avoid the extra's global Prettier probes, which can miss project-only Astro/Svelte plugins.
        condition = function(self, ctx)
          return self.cwd(self, ctx) ~= nil
        end,
      }
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "prettierd" } },
  },
}
