vim.cmd.packadd('nohlsearch')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-mini/mini.completion',
})

require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}
