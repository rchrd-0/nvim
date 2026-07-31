local root_markers = { ".typst-root", "typst.toml", ".git" }

local function find_typst_root(path)
  local absolute_path = vim.fn.fnamemodify(path, ":p")
  local start = vim.fs.dirname(absolute_path)

  local marker = vim.fs.find(root_markers, {
    path = start,
    upward = true,
  })[1]

  return marker and vim.fs.dirname(marker) or start
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tinymist = {
          root_markers = root_markers,
          settings = {
            formatterMode = "typstyle",
          },
        },
      },
    },
  },

  {
    "chomosuke/typst-preview.nvim",
    opts = {
      get_root = find_typst_root,
    },
  },
}
