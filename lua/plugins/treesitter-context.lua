return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPost',
  opts = {
    max_lines = 3, -- cap the sticky header height
    trim_scope = 'outer', -- when truncating, drop outermost context first
  },
}
