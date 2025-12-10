local au = require('core.util').aucmd
local ag = require('core.util').aug
-- Highlight text on yank
au('TextYankPost', 'kick-hl', {
  callback = function()
    vim.hl.on_yank()
  end,
})

au('LspAttach', 'lsp_attach_disable_ruff_hover', {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable ruff hover
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'Disable ruff hover on LSP attach',
})

-- I need to go through my config again to get it more idiomatic
-- right now I just want saved folds
local view_group = ag 'auto_view'
vim.api.nvim_create_autocmd({ 'BufWinLeave', 'BufWritePost', 'WinLeave' }, {
  desc = 'Save view with mkview for real files',
  group = view_group,
  callback = function(args)
    if vim.b[args.buf].view_activated then
      vim.cmd.mkview { mods = { emsg_silent = true } }
    end
  end,
})
vim.api.nvim_create_autocmd('BufWinEnter', {
  desc = 'Try to load file view if available and enable view saving for real files',
  group = view_group,
  callback = function(args)
    if not vim.b[args.buf].view_activated then
      local filetype = vim.api.nvim_get_option_value('filetype', { buf = args.buf })
      local buftype = vim.api.nvim_get_option_value('buftype', { buf = args.buf })
      local ignore_filetypes = { 'gitcommit', 'gitrebase', 'svg', 'hgcommit' }
      if buftype == '' and filetype and filetype ~= '' and not vim.tbl_contains(ignore_filetypes, filetype) then
        vim.b[args.buf].view_activated = true
        vim.cmd.loadview { mods = { emsg_silent = true } }
      end
    end
  end,
})
