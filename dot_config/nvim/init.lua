vim.g.mapleader = " "

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

vim.opt.swapfile = false

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/echasnovski/mini.pick" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

require "mini.pick".setup()
require "oil".setup()

local map = vim.keymap.set
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>h', ":Pick help<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>lf', vim.lsp.buf.format)

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.lemminx.setup({})

-- colorscheme
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd("hi Normal guibg=NONE")
vim.cmd(":hi statusline guibg=NONE")
