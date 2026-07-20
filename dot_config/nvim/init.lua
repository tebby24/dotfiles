-- options

vim.g.mapleader = " "

vim.o.number = true 
vim.o.relativenumber = true
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = false
vim.o.scrolloff = 10
vim.o.list = false
vim.o.confirm = true
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

-- autocommands

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})


-- plugins

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

-- keybinds
vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })


