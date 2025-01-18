return {
  {
    'christoomey/vim-tmux-navigator',
    init = function()
      -- Disable default mappings
      vim.g.tmux_navigator_no_mappings = 1
    end,
  },
}
