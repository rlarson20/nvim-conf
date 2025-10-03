return {
  dir = '~/src/Vimprove/nvim-plugin',
  config = function()
    require('vimprove').setup {
      cli_path = 'uv run --directory ~/src/Vimprove/ ~/src/Vimprove/cli.py',
      api_url = 'http://localhost:8000',
      model = 'anthropic/claude-4.5-sonnet',
    }
  end,
  cmd = { 'Vimprove', 'VimproveContext' },
}
