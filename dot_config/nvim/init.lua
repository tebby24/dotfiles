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

-- Helper: root detection (replaces root_pattern)
local function root_dir(fname)
  local root_files = { ".git", ".luarc.json", "compile_commands.json", "Makefile" }
  return vim.fs.dirname(vim.fs.find(root_files, { upward = true, path = fname })[1]) or vim.loop.cwd()
end

-- Plugin setup
require("lazy").setup({
  -- Theme
  {
    "vague2k/vague.nvim",
    config = function()
      require("vague").setup({ transparent = true })
      vim.cmd.colorscheme("vague")
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

  -- Telescope
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

  -- LSP (modern API)
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lsp = vim.lsp
      local configs = lsp.configs

      -- Define servers using new vim.lsp.config API
      configs.lua_ls = {
        default_config = {
          cmd = { "lua-language-server" },
          filetypes = { "lua" },
          root_dir = root_dir,
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
              workspace = { checkThirdParty = false },
            },
          },
        },
      }

      configs.clangd = {
        default_config = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "objc", "objcpp" },
          root_dir = root_dir,
        },
      }

      configs.lemminx = {
        default_config = {
          cmd = { "lemminx" },
          filetypes = { "xml", "xsd", "xsl", "xslt" },
          root_dir = root_dir,
        },
      }

      -- Start LSP servers
      lsp.start(configs.lua_ls)
      lsp.start(configs.clangd)
      lsp.start(configs.lemminx)

      -- LSP keymaps
      vim.keymap.set("n", "<leader>lf", function()
        vim.lsp.buf.format({ async = true })
      end, { desc = "Format file" })
    end,
  },
})

