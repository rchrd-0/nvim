return {
  'akinsho/bufferline.nvim',
  event = 'VeryLazy',
  version = '*',
  dependencies = 'nvim-tree/nvim-web-devicons',

  keys = {
    { '<S-h>', '<cmd>BufferLineCyclePrev<cr>', desc = 'Prev Buffer' },
    { '<S-l>', '<cmd>BufferLineCycleNext<cr>', desc = 'Next Buffer' },
    { '[T', '<cmd>BufferLineMovePrev<cr>', desc = 'Move buffer prev' },
    { ']T', '<cmd>BufferLineMoveNext<cr>', desc = 'Move buffer next' },
    { '<leader>bp', '<Cmd>BufferLineTogglePin<CR>', desc = 'Toggle [b]uffer [p]in' },
    { '<leader>bP', '<Cmd>BufferLineGroupClose ungrouped<CR>', desc = 'Delete Non-Pinned Buffers' },
    { '<leader>bl', '<Cmd>BufferLineCloseRight<CR>', desc = 'Delete [B]uffers to the Right' },
    { '<leader>bh', '<Cmd>BufferLineCloseLeft<CR>', desc = 'Delete [B]uffers to the Left' },
  },
  opts = {
    options = {
      always_show_bufferline = true,
      close_command = function(n)
        Snacks.bufdelete(n)
      end,
      right_mouse_command = function(n)
        Snacks.bufdelete(n)
      end,
      show_buffer_close_icons = false,
      diagnostics = 'nvim_lsp',
      diagnostics_indicator = function(count, level, diagnostics_dict, context)
        local icon = level:match 'error' and '  ' or level:match 'warning' and '  ' or '  '
        return ' ' .. icon .. ' ' .. count
      end,
    },
  },
  config = function(_, opts)
    require('bufferline').setup(opts)
    -- Fix bufferline when restoring a session
    vim.api.nvim_create_autocmd({ 'BufAdd', 'BufDelete' }, {
      callback = function()
        vim.schedule(function()
          pcall(nvim_bufferline)
        end)
      end,
    })
  end,
}
