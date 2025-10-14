vim.g.mapleader = " "

vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

vim.opt.clipboard = 'unnamedplus'

vim.opt.swapfile = false

vim.pack.add({
    { src = "https://github.com/vague2k/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", tag = "0.1.x" },
    { src = 'https://github.com/neovim/nvim-lspconfig' },
})

require"telescope".setup{}
require "oil".setup()

local map = vim.keymap.set
map('n', '<leader>f', ":Telescope find_files<CR>")
map('n', '<leader>h', ":Telescope help_tags<CR>")
map('n', '<leader>e', ":Oil<CR>")
map('n', '<leader>lf', vim.lsp.buf.format)

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.lemminx.setup({})

-- Treesitter
vim.cmd.packadd("nvim-treesitter")
require('nvim-treesitter.configs').setup {
    ensure_installed = { "lua", "c", "markdown", "markdown_inline" },
    highlight = { enable = true },
}

-- colorscheme
require "vague".setup({ transparent = true })
vim.cmd("colorscheme vague")
vim.cmd("hi Normal guibg=NONE")
vim.cmd(":hi statusline guibg=NONE")
