return {
  'toppair/peek.nvim',
  build = 'deno task --quiet build:fast',
  ft = 'markdown',
  keys = {
    {
      '<leader>mp',
      function()
        local peek = require 'peek'
        if peek.is_open() then
          peek.close()
        else
          peek.open()
        end
      end,
      desc = 'Markdown: peek preview',
    },
  },
  opts = { auto_load = false, theme = 'dark' },
}
