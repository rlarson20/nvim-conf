vim.api.nvim_create_user_command('OT2MDL', ':%! ~/src/bash/onetab_list_to_md_link.sh', {})

vim.keymap.set('n', '<leader>fm', ':OT2MDL<CR>', { desc = 'OneTab -> MD' })

vim.keymap.set('n', '<leader>mh', function()
  local level = vim.v.count1 -- defaults to 1 when no count is given
  level = math.min(level, 6) -- clamp to valid heading levels
  local prefix = string.rep('#', level) .. ' '
  vim.cmd 'normal o'
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { prefix })
  vim.cmd 'startinsert!'
end, { desc = 'Insert Markdown Heading (count = level, e.g. 3<leader>h for ###)' })

vim.keymap.set('n', '<leader>pl', function()
  local clipboard = vim.fn.getreg '+'
  local link_text = '[](' .. clipboard .. ')'
  local cur_line = vim.api.nvim_get_current_line()
  local row, col
  if cur_line:match '^#{1,6} ?$' then
    -- blank heading: append link inline, position inside []
    row = vim.api.nvim_win_get_cursor(0)[1]
    local insert_col = #cur_line
    -- ensure there's a space between hashes and link
    if not cur_line:match ' $' then
      vim.api.nvim_buf_set_text(0, row - 1, insert_col, row - 1, insert_col, { ' ' })
      insert_col = insert_col + 1
    end
    vim.api.nvim_buf_set_text(0, row - 1, insert_col, row - 1, insert_col, { link_text })
    col = insert_col + 1 -- inside the []
  else
    vim.cmd 'normal o'
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    row, col = cursor_pos[1], cursor_pos[2]
    vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { link_text })
    col = col + 1 -- inside the []
  end
  vim.api.nvim_win_set_cursor(0, { row, col })
  vim.cmd 'startinsert'
end, { desc = 'Paste Markdown Link and Title It' })

vim.opt_local.spell = true
vim.opt_local.spelllang = 'en_us'
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.conceallevel = 2
