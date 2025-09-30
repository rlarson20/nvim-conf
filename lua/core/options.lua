local M = {}

-- normal opts

local o = vim.o
local g = vim.g
local opt = vim.opt

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false
o.clipboard = 'unnamedplus'
o.breakindent = true
o.undofile = true
o.ignorecase = true
o.smartcase = true
o.signcolumn = 'yes'
o.updatetime = 250
o.timeoutlen = 300
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 15
o.confirm = true
o.splitright = true
o.splitbelow = true

o.foldmethod = 'manual'

-- disable some default providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- UI icon toggle
g.have_nerd_font = true
M.lazy_ui = {
  ui = { icons = g.have_nerd_font and {} or require('core.util').no_nerd_icons },
}

return M
