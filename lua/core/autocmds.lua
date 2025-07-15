local au = require('core.util').aucmd
-- Highlight text on yank
au('TextYankPost', 'kick-hl', {
  callback = function()
    vim.hl.on_yank()
  end,
})
