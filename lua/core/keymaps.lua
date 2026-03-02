local map = require('core.util').map
local n, t, v = 'n', 't', 'v'

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

-- Obsidian global capture: append current line or selection to inbox
local function obsidian_capture()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local mode = vim.fn.mode()
  if mode == 'v' or mode == 'V' then
    local s = vim.fn.line 'v'
    local e = vim.fn.line '.'
    if s > e then
      s, e = e, s
    end
    lines = vim.api.nvim_buf_get_lines(0, s - 1, e, false)
  else
    lines = { vim.api.nvim_get_current_line() }
  end
  local inbox = vim.fn.expand '~/Vaults/Laugh-Tale/00_Seedbox/inbox.md'
  local f = io.open(inbox, 'a')
  if f then
    f:write('\n' .. table.concat(lines, '\n'))
    f:close()
    vim.notify('Captured to inbox', vim.log.levels.INFO)
  end
end

map(n, '<leader>oi', obsidian_capture, 'Obsidian: capture line to inbox')
map(v, '<leader>oi', obsidian_capture, 'Obsidian: capture selection to inbox')
