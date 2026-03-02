return {
  'ThePrimeagen/refactoring.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-treesitter/nvim-treesitter' },
  keys = {
    {
      '<leader>re',
      function()
        require('refactoring').refactor 'Extract Function'
      end,
      mode = 'x',
      desc = 'Extract function',
    },
    {
      '<leader>rv',
      function()
        require('refactoring').refactor 'Extract Variable'
      end,
      mode = 'x',
      desc = 'Extract variable',
    },
    {
      '<leader>ri',
      function()
        require('refactoring').refactor 'Inline Variable'
      end,
      mode = { 'n', 'x' },
      desc = 'Inline variable',
    },
    {
      '<leader>rb',
      function()
        require('refactoring').refactor 'Extract Block'
      end,
      desc = 'Extract block',
    },
  },
  opts = {},
}
