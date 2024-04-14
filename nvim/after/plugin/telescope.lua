local builtin = require('telescope.builtin')
vim.keymap.set('n', '<C-p>', builtin.live_grep, {}) -- TODO: Fix the grep not greping
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
vim.keymap.set('n', '<leader>ps', function() -- Project search
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)
