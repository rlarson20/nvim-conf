return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-python',
    'rouge8/neotest-rust',
  },
  keys = {
    { '<leader>tn', function() require('neotest').run.run() end, desc = 'Test nearest' },
    { '<leader>tf', function() require('neotest').run.run(vim.fn.expand '%') end, desc = 'Test file' },
    { '<leader>ta', function() require('neotest').run.run(vim.fn.getcwd()) end, desc = 'Test all' },
    { '<leader>ts', function() require('neotest').summary.toggle() end, desc = 'Test summary' },
    { '<leader>to', function() require('neotest').output.open { enter = true } end, desc = 'Test output' },
    { '<leader>tO', function() require('neotest').output_panel.toggle() end, desc = 'Test output panel' },
    { '<leader>td', function() require('neotest').run.run { strategy = 'dap' } end, desc = 'Debug nearest test' },
    { '<leader>tw', function() require('neotest').watch.toggle(vim.fn.expand '%') end, desc = 'Watch file' },
    { '<leader>tl', function() require('neotest').run.run_last() end, desc = 'Run last test' },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = true },
          runner = 'pytest',
        },
        require 'neotest-rust',
      },
    }
  end,
}
