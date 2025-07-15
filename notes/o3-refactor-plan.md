Guide – Turning the “single-file kitchen-sink” into a clean, maintainable Neovim configuration
==============================================================================================

Your current `init.lua` works, but everything lives in one enormous file (plus a handful of `lua/custom/plugins/*.lua`).  That makes it hard to search, reason about dependencies, and re-use code.  
Below is a staged plan that will take you from today’s state → a modular, testable and self-documenting config without changing the plugin manager (`lazy.nvim`) or any of the behaviour you like.

────────────────────────────────────────────

1. High-level directory layout
────────────────────────────────────────────
~/.config/nvim
│
├── init.lua                     «ONLY loads the bootstrapper»
├── lua/
│   ├── core/                    «your own code, no 3rd-party»
│   │   ├── options.lua
│   │   ├── keymaps.lua
│   │   ├── autocmds.lua
│   │   ├── util.lua             «mini helpers (map(), augroup(), …)»
│   │   └── bootstrap.lua        «lazy.nvim bootstrap + core.setup() call»
│   │
│   ├── plugins/                 «all lazy-specs live here, ONE plugin = ONE file»
│   │   ├── editing/…            «logical sub-folders optional»
│   │   ├── lsp/…
│   │   ├── ui/…
│   │   └── init.lua             «returns a table that lazy can import»
│   │
│   └── ftplugin/                «file-type specific local tweaks»
│
└── after/
    └── ftplugin/…               «runtime overrides (rare)»

Nothing must live in `runtimepath` root except `init.lua`.

────────────────────────────────────────────
2.  Bootstrapping in 19 lines
────────────────────────────────────────────
init.lua

```lua
-- Do nothing but bootstrap and require the entry point -----------------------
require('core.bootstrap')
```

lua/core/bootstrap.lua

```lua
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {'git','clone','--filter=blob:none',
                 '--branch=stable','https://github.com/folke/lazy.nvim', lazypath }
end
vim.opt.rtp:prepend(lazypath)

-- Set leader BEFORE other modules
vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- Load core modules (options, keymaps, autocmds) -----------------------------
for _,mod in ipairs{'core.options','core.keymaps','core.autocmds'} do
  require(mod)
end

-- Load plugins (one line) ----------------------------------------------------
require('lazy').setup({{import = 'plugins'}}, require('core.options').lazy_ui)
```

Why?  
• keeps bootstrap independent of the rest  
• no globals leak (only `core.util` exports helpers)  
• later you can unit-test modules without loading plugins.

────────────────────────────────────────────
3.  Extract **Options**, **Keymaps**, **Autocmds**
────────────────────────────────────────────
core/options.lua

```lua
local M = {}

-- Normal vim options
local o = vim.o  -- alias
o.number         = true
o.relativenumber = true
o.mouse          = 'a'
o.showmode       = false
o.clipboard      = 'unnamedplus'
o.breakindent    = true
o.undofile       = true
o.ignorecase     = true
o.smartcase      = true
o.signcolumn     = 'yes'
o.updatetime     = 250
o.timeoutlen     = 300
o.list           = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
o.inccommand     = 'split'
o.cursorline     = true
o.scrolloff      = 15
o.confirm        = true
o.splitright     = true
o.splitbelow     = true

-- catppuccin and lazy ui icons toggle
vim.g.have_nerd_font = true
M.lazy_ui = {
  ui = { icons = vim.g.have_nerd_font and {} or require('core.util').no_nerd_icons }
}

return M
```

core/keymaps.lua

```lua
local map = require('core.util').map
local n,t = 'n','t'

-- <Esc> clears highlights
map(n,'<Esc>', '<cmd>nohlsearch<cr>', 'Clear search')

-- Diagnostics
map(n, '<leader>q', vim.diagnostic.setloclist, 'Quickfix diagnostics')

-- Terminal
map(t, '<Esc><Esc>', '<C-\\><C-n>', 'Exit Terminal')

-- Window nav
for lhs,rhs in pairs{['<C-h>']='h',['<C-j>']='j',['<C-k>']='k',['<C-l>']='l'} do
  map(n,lhs,'<C-w><C-'..rhs..'>','Focus '..rhs)
end

-- Your custom mappings (markdown link helper etc.) can be required
-- from a separate module to keep this file short:
require('core.mappings.markdown')
```

core/autocmds.lua

```lua
local au = require('core.util').aucmd
au('TextYankPost','kick-hl',{callback=function() vim.hl.on_yank() end})
```

Notice how the helper functions make each file declarative.

────────────────────────────────────────────
4.  Provide **core.util** helpers
────────────────────────────────────────────

```lua
local U = {}

function U.map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_deep_extend('force',
    {silent = true, desc = desc}, opts or {})
  vim.keymap.set(mode,lhs,rhs,opts)
end

function U.aug(name, clear) return vim.api.nvim_create_augroup(name, {clear=clear~=false}) end
function U.aucmd(event,name,opts)
  opts.group = U.aug(name)
  vim.api.nvim_create_autocmd(event, opts)
end

-- icons table when Nerd Font is missing
U.no_nerd_icons = { cmd='⌘', config='🛠', plugin='🔌', lazy='💤', … }

return U
```

Now `map()` is available everywhere by `require('core.util').map`.

────────────────────────────────────────────
5.  Split plugin specs into many tiny files
────────────────────────────────────────────
• One plugin = one file;  
• Filename = plugin repo (or purpose) so Telescope can fuzzy-find quickly;  
• Return the lazy-spec table, **no side-effects**.

Example:  `lua/plugins/ui/catppuccin.lua`

```lua
return {
  'catppuccin/nvim',
  name      = 'catppuccin',
  priority  = 1000,
  opts      = { transparent_background = true, flavour = 'mocha', … },
  init      = function() vim.cmd.colorscheme 'catppuccin' end,
}
```

`lua/plugins/lsp/init.lua`  
(may just collect a few related specs if you prefer grouping)

Important conventions:

1. **Never** modify global state in `opts` (defer to plugin).  
2. Put long custom functions in a separate `lua/plugins/_extras/<plugin>.lua` and `require` them; you avoid 500-line spec files.

You already started to put files in `lua/custom/plugins/…` – move them to `lua/plugins/` so they are first-class citizens.  
Delete the `custom` indirection unless you really need layering.

────────────────────────────────────────────
6.  File-type local overrides → `ftplugin/`
────────────────────────────────────────────
Everything under `after/ftplugin/markdown.lua` is loaded *only* for markdown buffers.  
Move things like:

```lua
vim.keymap.set('n','<leader>fm',':OT2MDL<CR>',{desc='OneTab -> MD'})
```

into `after/ftplugin/markdown.lua` – then they don’t pollute global keyspace.

────────────────────────────────────────────
7.  Use the **Which-Key** registration API
────────────────────────────────────────────
Instead of sprinkling descriptive `desc=`, register whole key-trees once:

```lua
require('which-key').register({
  ['<leader>'] = {
    s = { name = 'Search' },
    a = {
      name = 'Aider',
      ['+'] = 'Add file',
      ['-'] = 'Drop file',
    },
  }
})
```

Which-key will document everything and you no longer need to repeat `[S]earch …` mnemonic comments.

────────────────────────────────────────────
8.  Future proofing / Hot-reloading
────────────────────────────────────────────
Because every module returns a table and never mutates globals, you can hot-reload during development:

```lua
:lua R('core.keymaps')   -- R being a custom reload wrapper
```

Consider adding `folke/lua-dev.nvim` *or* `dNL` to get proper typing for your own modules.

────────────────────────────────────────────
9.  Progressive migration plan
────────────────────────────────────────────

- [x] Create `lua/core` and move options; commit.
- [ ] Move keymaps; commit.  
- [ ] Extract autocmds; commit.  
- [ ] Copy the bootstrapper & shrink `init.lua` to one line; commit.  
- [ ] Move two or three plugins at a time (they remain working); commit small.  
- [ ] When everything is modular, delete dead code & comments.

────────────────────────────────────────────
10.  Resulting benefits
────────────────────────────────────────────
• `init.lua` diff becomes tiny when upgrading Neovim.  
• Grepping for a keymap shows exactly one place.  
• Treesitter, LSP or UI concerns live in separate folders; onboarding a new machine is painless.  
• Unit-testing helpers (e.g. your markdown link generator) is possible without booting *all* of Neovim.  
• Telescope’s “Search files” across `lua/plugins/` is now instant.

Happy refactoring!
