return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = {
    options = {
      icons_enabled = true,
      theme = {
        normal = {
          a = { bg = '#FF3B3B', fg = '#141414', gui = 'bold' },
          b = { bg = '#1C1C1C', fg = '#E6E1DC' },
          c = { bg = '#141414', fg = '#B0AAA4' },
        },
        insert = {
          a = { bg = '#6FE7DD', fg = '#141414', gui = 'bold' },
        },
        visual = {
          a = { bg = '#C678DD', fg = '#141414', gui = 'bold' },
        },
        replace = {
          a = { bg = '#FF9E64', fg = '#141414', gui = 'bold' },
        },
        inactive = {
          a = { bg = '#141414', fg = '#3A3A3A' },
          b = { bg = '#141414', fg = '#3A3A3A' },
          c = { bg = '#141414', fg = '#3A3A3A' },
        },
      },
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diagnostics' },
      lualine_c = { 'filename' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'location' },
      lualine_z = {},
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  },
}
