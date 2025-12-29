# Neovim Configuration Improvement Plan

## Summary
Comprehensive refresh: integrate unused features, add navigation/session/AI, organize keymaps, and declutter.

---

## Phase 1: Integrate Snacks Keys (Quick Win)
**Goal:** Activate the ~80 keymaps sitting in `notes/snacks_keys_to_add.lua`

### Files to modify:
- `lua/plugins/snacks.lua` - Add the keys from notes file

### What this enables:
- Snacks.picker replacing Telescope for most searches
- `<leader>gg` for Lazygit
- `<c-/>` for terminal
- `<leader>f*` for find operations
- `<leader>g*` for git operations
- LSP navigation via snacks (`gd`, `gr`, `gI`, etc.)

---

## Phase 2: Organize Which-Key Groups
**Goal:** Add missing group definitions so which-key shows proper labels

### File to modify:
- `lua/plugins/which-key.lua`

### Groups to add:
```lua
spec = {
  { '<leader>b', group = '[B]uffer' },
  { '<leader>c', group = '[C]ode/AI' },
  { '<leader>d', group = '[D]ebug' },
  { '<leader>f', group = '[F]ind' },
  { '<leader>g', group = '[G]it' },
  { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  { '<leader>o', group = '[O]bsidian' },
  { '<leader>q', group = '[Q]uit/Session' },
  { '<leader>s', group = '[S]earch' },
  { '<leader>t', group = '[T]est' },
  { '<leader>u', group = '[U]I Toggle' },
  { '<leader>x', group = 'Trouble' },
},
```

---

## Phase 3: Add Obsidian Global Keymaps
**Goal:** Make Obsidian commands accessible without being in a vault file

### File to modify:
- `lua/plugins/obsidian.lua`

### Keymaps to add (global, not buffer-local):
| Key | Command | Description |
|-----|---------|-------------|
| `<leader>oo` | `:ObsidianQuickSwitch` | Find notes |
| `<leader>os` | `:ObsidianSearch` | Grep vault |
| `<leader>od` | `:ObsidianToday` | Today's daily note |
| `<leader>ob` | `:ObsidianBacklinks` | Show backlinks |
| `<leader>ot` | `:ObsidianTags` | Search by tags |
| `<leader>oT` | `:ObsidianTemplate` | Insert template |
| `<leader>ow` | `:ObsidianWorkspace` | Switch workspace |

---

## Phase 4: Add Flash.nvim (Navigation)
**Goal:** Quick cursor movement with search labels

### File to create:
- `lua/plugins/flash.lua`

### Config:
```lua
return {
  'folke/flash.nvim',
  event = 'VeryLazy',
  opts = {},
  keys = {
    { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash' },
    { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
    { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
    { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
  },
}
```

---

## Phase 5: Add Session Management (persistence.nvim)
**Goal:** Save/restore sessions per project

### File to create:
- `lua/plugins/persistence.lua`

### Config:
```lua
return {
  'folke/persistence.nvim',
  event = 'BufReadPre',
  opts = {},
  keys = {
    { '<leader>qs', function() require('persistence').load() end, desc = 'Restore Session' },
    { '<leader>qS', function() require('persistence').select() end, desc = 'Select Session' },
    { '<leader>ql', function() require('persistence').load({ last = true }) end, desc = 'Restore Last' },
    { '<leader>qd', function() require('persistence').stop() end, desc = "Don't Save" },
  },
}
```

---

## Phase 6: Add AI Assistant (codecompanion.nvim)
**Goal:** Integrate Claude for code assistance

### File to create:
- `lua/plugins/codecompanion.lua`

### Config:
```lua
return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  keys = {
    { '<leader>cc', '<cmd>CodeCompanionChat Toggle<cr>', desc = 'Toggle Chat', mode = { 'n', 'v' } },
    { '<leader>ca', '<cmd>CodeCompanionActions<cr>', desc = 'Actions', mode = { 'n', 'v' } },
    { '<leader>ci', '<cmd>CodeCompanion<cr>', desc = 'Inline', mode = { 'n', 'v' } },
  },
  opts = {
    strategies = {
      chat = { adapter = 'anthropic' },
      inline = { adapter = 'anthropic' },
    },
    adapters = {
      anthropic = function()
        return require('codecompanion.adapters').extend('anthropic', {
          env = { api_key = 'ANTHROPIC_API_KEY' },
        })
      end,
    },
  },
}
```

**Note:** Requires `ANTHROPIC_API_KEY` environment variable.

---

## Phase 7: Enhance Existing Plugins

### 7a. Neotest - Add more adapters and keymaps
**File:** `lua/plugins/neotest.lua`

- Add `neotest-rust` adapter
- Add debug test keymap: `<leader>td`
- Add run all: `<leader>ta`
- Add watch mode: `<leader>tw`

### 7b. DAP - Add missing keymaps
**File:** `lua/plugins/lsp/debug.lua`

- `<leader>dc` - Run to cursor
- `<leader>de` - Evaluate expression
- `<leader>dr` - Toggle REPL
- Add `codelldb` for Rust debugging

### 7c. Iron.nvim Decision
**File:** `lua/plugins/iron.lua`

**Option A (Enhance):** If you do Python REPL work, configure properly with ipython and send-code keymaps.

**Option B (Remove):** If not, remove and rely on snacks terminal (`<c-/>`).

*User decision needed during implementation.*

---

## Phase 8: Cleanup

### 8a. Remove telescope duplication
- After snacks integration, evaluate if telescope.lua can be simplified
- Many pickers will be handled by snacks.picker

### 8b. Archive notes file
- Move `notes/snacks_keys_to_add.lua` to `notes/archive/` after integration

### 8c. Fix obsidian.nvim dependency
- Line 18 references `hrsh7th/nvim-cmp` but you use blink.cmp
- Update to use blink.cmp or remove if not needed

---

## Implementation Order

1. **Phase 1** - Snacks keys (biggest impact, immediate usability boost)
2. **Phase 2** - Which-key groups (makes keymaps discoverable)
3. **Phase 3** - Obsidian keymaps (you already have the plugin)
4. **Phase 4** - Flash.nvim (navigation improvement)
5. **Phase 5** - Persistence (session management)
6. **Phase 6** - CodeCompanion (AI assistance)
7. **Phase 7** - Enhance neotest/DAP
8. **Phase 8** - Cleanup

---

## Critical Files Summary

| File | Action |
|------|--------|
| `lua/plugins/snacks.lua` | Add keys from notes |
| `lua/plugins/which-key.lua` | Add group definitions |
| `lua/plugins/obsidian.lua` | Add global keymaps |
| `lua/plugins/flash.lua` | Create new |
| `lua/plugins/persistence.lua` | Create new |
| `lua/plugins/codecompanion.lua` | Create new |
| `lua/plugins/neotest.lua` | Add adapters/keymaps |
| `lua/plugins/lsp/debug.lua` | Add keymaps |
| `lua/plugins/iron.lua` | Enhance or remove |
