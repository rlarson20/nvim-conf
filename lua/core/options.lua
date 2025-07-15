local M = {}

-- normal opts

local o = vim.o

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
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand = 'split'
o.cursorline = true
o.scrolloff = 15
o.confirm = true
o.splitright = true
o.splitbelow = true

-- UI icon toggle
vim.g.have_nerd_font = true
M.lazy_ui = {
  ui = { icons = vim.g.have_nerd_font and {} or require('core.util').no_nerd_icons },
}

return M
