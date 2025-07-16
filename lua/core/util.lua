local U = {}

function U.map(mode, lhs, rhs, desc, opts)
  opts = vim.tbl_deep_extend('force', { silent = true, desc = desc }, opts or {})
  vim.keymap.set(mode, lhs, rhs, opts)
end

function U.aug(name, clear)
  return vim.api.nvim_create_augroup(name, { clear = clear ~= false })
end

function U.aucmd(event, name, opts)
  opts.group = U.aug(name)
  vim.api.nvim_create_autocmd(event, opts)
end

-- icons table when Nerd Font is missing
U.no_nerd_icons = {
  cmd = '⌘',
  config = '🛠',
  event = '📅',
  ft = '📂',
  init = '⚙',
  keys = '🗝',
  plugin = '🔌',
  runtime = '💻',
  require = '🌙',
  source = '📄',
  start = '🚀',
  task = '📌',
  lazy = '💤 ',
}

function U.safe_require(mod_name)
  local status, mod = pcall(require, mod_name)
  if not status then
    vim.notify('Failed to load ' .. mod_name, vim.log.levels.WARN)
    return nil
  end
  return mod
end

return U
