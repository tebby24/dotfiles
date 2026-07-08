vim.g.mapleader = " "
vim.g.mapleader = ' '
vim.o.number = true 
vim.o.relativenumber = true
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.list = true
vim.o.confirm = true

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.hl.on_yank()
  end,
})

-- plugins

vim.cmd.packadd('nohlsearch')

vim.pack.add({
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/ibhagwan/fzf-lua',
  'https://github.com/nvim-mini/mini.completion',
})

require('fzf-lua').setup { fzf_colors = true }
require('mini.completion').setup {}

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.opt.termguicolors = true
