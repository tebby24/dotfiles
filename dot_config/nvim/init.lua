-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    -- Theme
    {
        "vague2k/vague.nvim",
        config = function()
            require("vague").setup({ transparent = true })
            vim.cmd.colorscheme("vague")
        end,
    },

    -- File explorer
    {
        "stevearc/oil.nvim",
        opts = {},
        keys = {
            { "<leader>e", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
        },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua", "c", "markdown", "markdown_inline" },
            highlight = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },

    -- Telescope
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local telescope = require("telescope")
            telescope.setup({})
            vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
            vim.keymap.set("n", "<leader>h", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
        end,
    },

    -- LSP
    {
        "neovim/nvim-lspconfig",
        -- you can even make it `lazy = true` since only configurations are needed
        config = function()
            -- Global defaults
            vim.lsp.config("*", {
                on_attach = function(client, bufnr)
                    local bufopts = { buffer = bufnr }
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
                    -- etc
                end,
                root_markers = { ".git", "Makefile", "compile_commands.json" },
            })

            -- Lua override
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- Clang override (if any)
            vim.lsp.config("clangd", {
                -- you can add extra commands or settings here
            })

            -- Enable servers
            vim.lsp.enable({ "lua_ls", "clangd" })
        end,
    },
})

