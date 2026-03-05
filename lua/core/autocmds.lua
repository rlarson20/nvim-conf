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
