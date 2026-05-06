return {
  dir = '~/src/tools/Vimprove/nvim-plugin',
  config = function()
    require('vimprove').setup {
      cli_path = 'uv run --directory ~/src/tools/Vimprove/ ~/src/tools/Vimprove/cli.py',
      api_url = 'http://localhost:8000',
      model = 'anthropic/claude-4.5-sonnet',
    }
  end,
  cmd = { 'Vimprove', 'VimproveContext' },
}
