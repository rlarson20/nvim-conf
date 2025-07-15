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

-- Your custom mappings (markdown link helper etc.) can be required
-- from a separate module to keep this file short:
-- require('core.mappings.markdown')
