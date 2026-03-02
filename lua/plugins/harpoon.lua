return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  keys = function()
    local harpoon = require 'harpoon'
    return {
      {
        '<leader>ha',
        function()
          harpoon:list():add()
        end,
        desc = 'Harpoon add',
      },
      {
        '<leader>hh',
        function()
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = 'Harpoon menu',
      },
      {
        '<C-1>',
        function()
          harpoon:list():select(1)
        end,
        desc = 'Harpoon 1',
      },
      {
        '<C-2>',
        function()
          harpoon:list():select(2)
        end,
        desc = 'Harpoon 2',
      },
      {
        '<C-3>',
        function()
          harpoon:list():select(3)
        end,
        desc = 'Harpoon 3',
      },
      {
        '<C-4>',
        function()
          harpoon:list():select(4)
        end,
        desc = 'Harpoon 4',
      },
    }
  end,
  config = function()
    require('harpoon'):setup()
  end,
}
