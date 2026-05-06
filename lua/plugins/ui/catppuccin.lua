return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  opts = {
    transparent_background = true,
    flavour = 'mocha',

    color_overrides = {
      mocha = {
        base = '#141414',
        mantle = '#101010',
        crust = '#0C0C0C',

        text = '#E6E1DC',
        subtext1 = '#B0AAA4',
        subtext0 = '#8A847F',

        surface0 = '#1C1C1C',
        surface1 = '#2A2A2A',
        surface2 = '#3A3A3A',

        overlay0 = '#454545',
        overlay1 = '#505050',
        overlay2 = '#5A5A5A',

        -- accents (key part)
        red = '#FF3B3B',
        maroon = '#FF5A5F',
        peach = '#FF9E64',
        yellow = '#FFB86C',
        green = '#A3BE8C',
        teal = '#56C2B8',
        sky = '#6FE7DD',
        sapphire = '#6FE7DD',
        blue = '#6FE7DD',
        lavender = '#C678DD',
        mauve = '#C678DD',
        pink = '#D8A4F0',
        flamingo = '#FF7A7A',
        rosewater = '#F2EDE7',
      },
    },
    highlight_overrides = {
      mocha = function(C)
        return {
          CursorLine = { bg = '#1A1A1A' },

          Visual = { bg = '#6FE7DD', fg = '#141414' },

          Comment = { fg = '#6A6560', italic = true },

          -- Diagnostics = emotional tone
          DiagnosticError = { fg = C.red, bold = true },
          DiagnosticWarn = { fg = C.peach },
          DiagnosticInfo = { fg = C.blue },
          DiagnosticHint = { fg = C.teal },

          -- Strings feel “organic”
          String = { fg = '#FF9E64' },

          -- Functions pop in cyan
          Function = { fg = '#6FE7DD', bold = true },

          -- Keywords = aggressive
          Keyword = { fg = '#FF3B3B', italic = true },

          -- Types = bruised purple
          Type = { fg = '#C678DD' },

          -- Search hits hard
          Search = { bg = '#FF3B3B', fg = '#141414' },
          IncSearch = { bg = '#6FE7DD', fg = '#141414' },

          -- Line numbers subtle
          LineNr = { fg = '#3A3A3A' },
          CursorLineNr = { fg = '#FF3B3B', bold = true },
        }
      end,
    },
  },
  init = function()
    vim.cmd.colorscheme 'catppuccin'
  end,
}
