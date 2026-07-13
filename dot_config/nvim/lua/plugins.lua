vim.cmd.packadd('nohlsearch')

vim.pack.add({
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/stevearc/oil.nvim',
})

require('vague').setup { transparent = true }
vim.cmd.colorscheme('vague')

require('fzf-lua').setup { fzf_colors = true }

require("oil").setup()
