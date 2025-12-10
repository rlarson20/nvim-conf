local M = {}

-- normal opts

local o = vim.o
local g = vim.g

-- local a = vim.api

local opt = vim.opt

-- cursor visibility
o.cursorline = true
o.cursorlineopt = 'screenline'
o.cursorcolumn = true

-- line number stuff
o.number = true
o.relativenumber = true
o.mouse = 'a'
o.showmode = false -- dont need because lualine
o.clipboard = 'unnamedplus'
o.undofile = true

--case stuff
o.ignorecase = true
o.smartcase = true

o.signcolumn = 'yes'
o.updatetime = 500
o.timeoutlen = 300
o.list = true
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- substitution preview
o.inccommand = 'split'
o.scrolloff = 999 -- want to stay in middle
o.confirm = true
o.splitright = true
o.splitbelow = true

o.foldmethod = 'manual'
-- o.foldlevel = 4

-- better indentation management
o.autoindent = true
o.copyindent = true
o.breakindent = true

-- limit popup size
o.pumheight = 5

-- disable some default providers
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0

-- UI icon toggle
g.have_nerd_font = true
M.lazy_ui = {
  ui = { icons = g.have_nerd_font and {} or require('core.util').no_nerd_icons },
}

return M
