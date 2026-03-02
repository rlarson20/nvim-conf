return {
  generator = function(_, cb)
    local stdout = {}
    vim.fn.jobstart({ 'just', '--list', '--list-prefix', '', '--list-heading', '' }, {
      stdout_buffered = true,
      on_stdout = function(_, data)
        stdout = data
      end,
      on_exit = function()
        local tasks = {}
        for _, line in ipairs(stdout) do
          local name = line:match '^(%S+)'
          if name then
            table.insert(tasks, {
              name = 'just ' .. name,
              builder = function()
                return { cmd = { 'just', name } }
              end,
            })
          end
        end
        cb(tasks)
      end,
    })
  end,
  condition = {
    callback = function()
      return vim.fn.executable 'just' == 1
    end,
  },
}
