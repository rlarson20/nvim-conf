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
  -- We'll use the built-in `help_tags` picker because it correctly finds all help pages.
  -- We just need to tell it what to do when we press Enter.
  require('telescope.builtin').help_tags {
    attach_mappings = function(prompt_bufnr, mapping)
      local actions = require 'telescope.actions'
      local action_state = require 'telescope.actions.state'

      -- This is our custom action. It will run when we press <CR>.
      local open_in_new_tab_and_return = function()
        -- Get the currently selected entry in Telescope
        local selection = action_state.get_selected_entry()
        -- Close the Telescope window
        actions.close(prompt_bufnr)
        if selection then
          -- Run the vim command to open the help page in a new tab,
          -- then immediately switch back to the previous tab.
          vim.cmd('tab help ' .. vim.fn.fnameescape(selection.value) .. ' | tabprevious')
        end
      end

      -- Now, we map our custom action to the Enter key for both insert and normal mode.
      mapping('i', '<CR>', open_in_new_tab_and_return)
      mapping('n', '<CR>', open_in_new_tab_and_return)

      -- By returning `true`, we tell Telescope that we've set up all the mappings
      -- we need, so it shouldn't apply its own defaults (which would override ours).
      -- This ensures that the other default keys like C-v/C-x for splits still work.
      return true
    end,
  }
end, '[S]earch Help in New [T]ab')

-- Your custom mappings (markdown link helper etc.) can be required
-- from a separate module to keep this file short:
-- require('core.mappings.markdown')
