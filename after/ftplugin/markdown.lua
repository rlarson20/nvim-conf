vim.api.nvim_create_user_command('OT2MDL', ':%! ~/src/bash/onetab_list_to_md_link.sh', {})

vim.keymap.set('n', '<leader>fm', ':OT2MDL<CR>', { desc = 'OneTab -> MD' })
vim.keymap.set('n', '<leader>pl', function()
  local clipboard = vim.fn.getreg '+'
  local link_text = '[](' .. clipboard .. ')'
  vim.cmd 'normal o'
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { link_text })
  vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  vim.cmd 'startinsert'
end, { desc = 'Paste Markdown Link and Title It' })
