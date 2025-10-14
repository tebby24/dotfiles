-- Leader key
vim.g.mapleader = " "

-- Basic options
vim.opt.number = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"
vim.opt.clipboard = "unnamedplus"
vim.opt.swapfile = false

-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin setup
require("lazy").setup({
  -- Theme
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({ transparent = true })
      vim.cmd("colorscheme vague")
      vim.cmd("hi Normal guibg=NONE")
      vim.cmd("hi StatusLine guibg=NONE")
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

  -- Telescope (with dependency)
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({})
      local map = vim.keymap.set
      map("n", "<leader>f", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
      map("n", "<leader>h", "<cmd>Telescope help_tags<CR>", { desc = "Help tags" })
    end,
  },

  -- LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
      lspconfig.clangd.setup({})
      lspconfig.lemminx.setup({})
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format file" })
    end,
  },
})

