-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
vim.o.winborder = "rounded"
vim.opt.termguicolors = true

-- Disable netrw so Oil can take over file browsing
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Built-in plugin manager 
vim.pack.add({
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
}, { load = true })

-- Theme
require("vague").setup({
    transparent = true,
    on_highlights = function(hl, _)
        hl.StatusLine = { bg = "none" }
        hl.StatusLineNC = { bg = "none" }
    end,
})
vim.cmd.colorscheme("vague")

-- File explorer
require("oil").setup({
    default_file_explorer = true,
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {
    desc = "Open Oil file explorer",
})

-- Treesitter
-- Keep nvim-treesitter for parsers/queries, but let Neovim handle highlighting.
require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        pcall(vim.treesitter.start, args.buf)
    end,
})

-- Telescope
require("telescope").setup({})

vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", {
    desc = "Find files",
})
vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<CR>", {
    desc = "Help tags",
})
vim.keymap.set("n", "<leader>p", "<cmd>Telescope commands<CR>", {
    desc = "Commands",
})

-- Autopairs
require("nvim-autopairs").setup({})
