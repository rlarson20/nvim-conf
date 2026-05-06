-- nvim 0.12 changed query directives so `match[capture_id]` is now a TSNode[]
-- instead of a single TSNode. nvim-treesitter master is archived and its
-- directive handlers (e.g. set-lang-from-info-string!) still pass that list
-- straight to get_node_text, which crashes inside get_range with
-- "attempt to call method 'range' (a nil value)".
local orig_get_node_text = vim.treesitter.get_node_text
---@diagnostic disable-next-line: duplicate-set-field
vim.treesitter.get_node_text = function(node, source, opts)
  if type(node) == 'table' then node = node[1] end
  if not node then return '' end
  return orig_get_node_text(node, source, opts)
end

local orig_get_range = vim.treesitter.get_range
---@diagnostic disable-next-line: duplicate-set-field
vim.treesitter.get_range = function(node, source, metadata)
  if type(node) == 'table' then node = node[1] end
  return orig_get_range(node, source, metadata)
end
