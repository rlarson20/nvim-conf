return {
  'benomahony/uv.nvim',
  ft = { 'python' },
  opts = {
    -- Auto-activate virtual environments when found
    auto_activate_venv = true,

    -- Auto commands for directory changes
    auto_commands = true,

    -- Integration with snacks picker
    picker_integration = false, --TODO: fix snacks

    -- Keymaps to register (set to false to disable)
    keymaps = {
      prefix = '<leader>pu', -- Main prefix for uv commands (Python UV)
      commands = true, -- Show uv commands menu (<leader>pu)
      run_file = true, -- Run current file (<leader>pur)
      run_selection = true, -- Run selected code (<leader>pus)
      run_function = true, -- Run function (<leader>puf)
      venv = true, -- Environment management (<leader>pue)
      init = true, -- Initialize uv project (<leader>pui)
      add = true, -- Add a package (<leader>pua)
      remove = true, -- Remove a package (<leader>pud)
      sync = true, -- Sync packages (<leader>puc)
    },

    -- Execution options
    execution = {
      -- Python run command template
      run_command = 'uv run python',

      -- Show output in notifications
      notify_output = true,

      -- Notification timeout in ms
      notification_timeout = 10000,
    },
  },
}
