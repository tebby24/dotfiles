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

-- Disable netrw so Oil can take over file browsing
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Built-in plugin manager (Neovim 0.12+)
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


-- Only highlight with treesitter
vim.cmd('syntax off')


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

    -- Global defaults for all LSP servers
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

-- Yank highlight
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
})
