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
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

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
        lazy = false,
        opts = {
            default_file_explorer = true,
        },
        keys = {
            { "<leader>e", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
        },
        dependencies = { "nvim-tree/nvim-web-devicons" },
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "lua", "c", "cpp", "markdown", "markdown_inline", "python" },
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


    {
        "neovim/nvim-lspconfig",
        config = function()
            local border = "rounded"

            ------------------------------------------------------------------
            -- UI: borders everywhere
            ------------------------------------------------------------------
            vim.lsp.handlers["textDocument/hover"] =
            vim.lsp.with(vim.lsp.handlers.hover, { border = border })

            vim.lsp.handlers["textDocument/signatureHelp"] =
            vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })

            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = border,
                    source = "always",
                    header = "",
                    prefix = "",
                },
            })

            ------------------------------------------------------------------
            -- Global LSP defaults
            ------------------------------------------------------------------
            vim.lsp.config("*", {
                root_markers = {
                    ".git",
                    "pyproject.toml",
                    "setup.py",
                    "Makefile",
                    "package.json",
                },

                on_attach = function(_, bufnr)
                    -- Always enable diagnostics for this buffer
                    vim.diagnostic.enable(true, { bufnr = bufnr })

                    local opts = { buffer = bufnr }

                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
                    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
                    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
                    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

                    -- Force rounded border for hover (reliable fix)
                    vim.keymap.set("n", "K", function()
                        vim.lsp.buf.hover({ border = border })
                    end, opts)
                end,
            })

            ------------------------------------------------------------------
            -- Server-specific config
            ------------------------------------------------------------------

            -- Lua (Neovim runtime awareness)
            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                    },
                },
            })

            -- Python (pyright)
            vim.lsp.config("pyright", {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic", -- or "strict"
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                        },
                    },
                },
            })

            ------------------------------------------------------------------
            -- Enable servers
            ------------------------------------------------------------------
            vim.lsp.enable({
                "lua_ls",
                "clangd",
                "marksman",
                "pyright",
            })

            ------------------------------------------------------------------
            -- Diagnostic navigation
            ------------------------------------------------------------------
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
            vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float)
        end,
    }

})

