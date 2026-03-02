return {
  'stevearc/overseer.nvim',
  cmd = { 'OverseerRun', 'OverseerToggle' },
  keys = {
    { '<leader>or', '<cmd>OverseerRun<cr>', desc = 'Overseer: run task' },
    { '<leader>ot', '<cmd>OverseerToggle<cr>', desc = 'Overseer: toggle output' },
  },
  opts = {
    templates = { 'builtin', 'user.just' },
    task_list = { direction = 'bottom', min_height = 10 },
  },
}
