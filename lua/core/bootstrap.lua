local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', 'https://github.com/folke/lazy.nvim', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Set leader BEFORE other modules
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Load core modules (options, keymaps, autocmds) -----------------------------
for _, mod in ipairs { 'core.options', 'core.keymaps', 'core.autocmds', 'core.usercmds' } do
  require(mod)
end

for _, p in ipairs {
  '2html_plugin',
  'gzip',
  'matchit',
  'matchparen',
  'netrwPlugin',
  'tarPlugin',
  'tohtml',
  'tutor',
  'zipPlugin',
} do
  vim.g['loaded_' .. p] = 1
end

-- Load plugins (one line) ----------------------------------------------------
require('lazy').setup {
  spec = { { import = 'plugins' }, { import = 'plugins.editing' }, { import = 'plugins.lsp' }, { import = 'plugins.ui' } },
  install = { colorscheme = { 'catppuccin' } },
  require('core.options').lazy_ui,
}
