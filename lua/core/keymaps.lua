local map = require('core.util').map
local n, t = 'n', 't'

-- <Esc> clears highlights
map(n, '<Esc>', '<cmd>nohlsearch<cr>', 'Clear search')

-- Diagnostics
map(n, '<leader>q', vim.diagnostic.setloclist, 'Quickfix diagnostics')

-- Window nav
for lhs, rhs in pairs { ['<C-h>'] = 'h', ['<C-j>'] = 'j', ['<C-k>'] = 'k', ['<C-l>'] = 'l' } do
  map(n, lhs, '<C-w><C-' .. rhs .. '>', 'Focus ' .. rhs)
end

map(n, '<Leader>st', function()
  -- Use snacks picker for help tags, opening the selected page in a new tab
  -- and returning to the previous tab (same behaviour as the old telescope mapping).
  Snacks.picker.help {
    confirm = function(picker, item)
      if item then
        picker:close()
        vim.cmd('tab help ' .. vim.fn.fnameescape(item.text) .. ' | tabprevious')
      end
    end,
  }
end, '[S]earch Help in New [T]ab')

map(n, 'grT', ':tabclose<CR>', '[r]emove [t]ab')

map(n, '<leader>l', ':Lazy<CR>', 'Lazy')
-- Your custom mappings (markdown link helper etc.) can be required
-- from a separate module to keep this file short:
-- require('core.mappings.markdown')
