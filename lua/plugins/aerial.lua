return {
  'stevearc/aerial.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
  keys = {
    { '<leader>cs', '<cmd>AerialToggle!<cr>', desc = 'Outline (Aerial)' },
    { '{', '<cmd>AerialPrev<cr>', desc = 'Prev symbol' },
    { '}', '<cmd>AerialNext<cr>', desc = 'Next symbol' },
  },
  opts = {
    backends = { 'treesitter', 'lsp', 'markdown', 'man' },
    layout = { default_direction = 'right', min_width = 30 },
    attach_mode = 'global',
    show_guides = true,
  },
}
