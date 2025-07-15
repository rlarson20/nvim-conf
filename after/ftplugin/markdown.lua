vim.api.nvim_create_user_command('OT2MDL', ':%! ~/src/bash/onetab_list_to_md_link.sh', {})

vim.keymap.set('n', '<leader>fm', ':OT2MDL<CR>', { desc = 'OneTab -> MD' })
