-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.o.winborder = "rounded"
vim.opt.signcolumn = "yes"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false
<<<<<<< HEAD
vim.opt.ignorecase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.virtualedit = "block"

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
=======

-- Disable netrw early so Oil can take over file browsing
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Built-in plugin manager (Neovim 0.12+)
-- load = true is important in init.lua so plugins are available immediately.
vim.pack.add({
    { src = "https://github.com/vague-theme/vague.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/nvim-telescope/telescope.nvim", version = "0.1.8" },
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
}, { load = true })
>>>>>>> a989522 (Update .config/nvim/init.lua)

-- Keep Treesitter parser updates roughly equivalent to lazy.nvim's :TSUpdate hook
vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(ev)
        local spec = ev.data.spec
        if not spec then
            return
        end

        if spec.name == "nvim-treesitter" and (ev.data.kind == "install" or ev.data.kind == "update") then
            vim.schedule(function()
                pcall(vim.cmd, "TSUpdate")
            end)
        end
    end,
})

-- Theme
require("vague").setup({
    transparent = true,
    on_highlights = function(hl, _)
        hl.StatusLine = { bg = "none" }
        hl.StatusLineNC = { bg = "none" }
    end,
})
vim.cmd("colorscheme vague")

-- File explorer
require("oil").setup({
    default_file_explorer = true,
})

vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", {
    desc = "Open Oil file explorer",
})

-- Treesitter
require("nvim-treesitter.configs").setup({
    ensure_installed = { "lua", "c", "cpp", "markdown", "markdown_inline", "python" },
    highlight = { enable = true },
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

-- LSP
do
    local border = "rounded"

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

    -- Global LSP defaults
    vim.lsp.config("*", {
        root_markers = {
            ".git",
            "pyproject.toml",
            "setup.py",
            "Makefile",
            "package.json",
        },

        on_attach = function(_, bufnr)
            vim.diagnostic.enable(true, { bufnr = bufnr })

            local opts = { buffer = bufnr, silent = true }

            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)

            vim.keymap.set("n", "K", function()
                vim.lsp.buf.hover({ border = border })
            end, opts)
        end,
    })

    -- Server-specific config
    vim.lsp.config("lua_ls", {
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
                workspace = { checkThirdParty = false },
            },
        },
    })

    vim.lsp.config("pyright", {
        settings = {
            python = {
                analysis = {
                    typeCheckingMode = "basic",
                    autoSearchPaths = true,
                    useLibraryCodeForTypes = true,
                },
            },
        },
    })

    -- Enable servers
    vim.lsp.enable({
        "lua_ls",
        "clangd",
        "marksman",
        "pyright",
    })

    -- Diagnostic navigation
    vim.keymap.set("n", "[d", function()
        vim.diagnostic.jump({ count = -1, float = true })
    end, { desc = "Previous diagnostic" })

    vim.keymap.set("n", "]d", function()
        vim.diagnostic.jump({ count = 1, float = true })
    end, { desc = "Next diagnostic" })

    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
        desc = "Line diagnostics",
    })
end

