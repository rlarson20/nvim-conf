return {
  'nvim-telescope/telescope.nvim',
  cmd = { 'Telescope' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'lucirukei/telescope-tab-picker.nvim' },
  },
  config = function()
    require('telescope').setup {
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
        ['telescope-tab-picker'] = {
          filename_modifier = ':t',
          filename_separator = ', ',
          title_fn_modifier = ':.',
          create_command = true,
          command_name = 'TabPicker',
          display_amount = true,
          sorter = require('telescope.sorters').get_fuzzy_file,
          mappings = {
            ['<cr>'] = require('telescope-tab-picker').select_entry,
            ['<c-k>'] = require('telescope-tab-picker').step_up,
            ['<c-j>'] = require('telescope-tab-picker').step_down,
          },
        },
      },
    }

    -- Load extensions
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
  end,
}
