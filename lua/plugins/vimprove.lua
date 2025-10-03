return {
  dir = '~/src/Vimprove/nvim-plugin',
  config = function()
    require('vimprove').setup {
      cli_path = 'uv run ~/src/Vimprove/cli.py',
      api_url = 'http://localhost:8000',
    }
  end,
  cmd = { 'Vimprove', 'VimproveContext' },
}
