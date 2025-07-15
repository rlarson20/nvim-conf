return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    transparent_background = true,
    flavour = 'mocha',
    integrations = {
      cmp = true,
      gitsigns = true,
      treesitter = true,
      notify = true,
      markdown = true,
      flash = true,
      -- harpoon = true,
      indent_blankline = {
        enabled = true,
        scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
        colored_indent_levels = false,
      },
      mason = true,
      neotree = true,
      noice = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
          ok = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
          ok = { 'underline' },
        },
        inlay_hints = {
          background = true,
        },
      },
      render_markdown = true,
      snacks = {
        enabled = false,
        indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
      },
      telescope = { enabled = true },
      which_key = true,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
