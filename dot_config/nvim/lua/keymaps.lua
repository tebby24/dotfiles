vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end)
vim.keymap.set('n', '<leader>fg', function() require('fzf-lua').live_grep() end)
vim.keymap.set('n', '<leader>fh', function() require('fzf-lua').help_tags() end)
