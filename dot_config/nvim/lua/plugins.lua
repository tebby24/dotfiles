vim.cmd.packadd('nohlsearch')

vim.pack.add({
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/nvim-mini/mini.completion',
})

vim.cmd.colorscheme('vague')
require('vague').setup { transparent = true }

require('fzf-lua').setup { fzf_colors = true }

require('mini.completion').setup {}
