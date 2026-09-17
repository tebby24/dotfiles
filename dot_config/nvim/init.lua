-- #######
-- OPTIONS
-- #######

vim.loader.enable()

vim.g.mapleader = " "

vim.o.mouse = 'a'
vim.o.relativenumber = true
vim.o.clipboard = 'unnamedplus'
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = false
vim.o.scrolloff = 30
vim.o.list = true
vim.opt.listchars = { leadmultispace = '│   ', tab = '│ ' }
vim.o.confirm = true
vim.o.signcolumn = "yes"
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.opt.splitright = true

-- ############
-- AUTOCOMMANDS
-- ############

vim.api.nvim_create_autocmd('TextYankPost', {
    desc = 'Highlight when yanking (copying) text',
    callback = function()
        vim.hl.on_yank()
    end,
})

-- #######
-- PLUGINS
-- #######

vim.cmd.packadd('nohlsearch')
vim.pack.add({
    'https://github.com/vague-theme/vague.nvim',
    'https://github.com/loctvl842/monokai-pro.nvim',
    'https://github.com/sainnhe/sonokai',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/ibhagwan/fzf-lua',
    'https://github.com/stevearc/oil.nvim',
    'https://github.com/m4xshen/autoclose.nvim',
    'https://github.com/nvim-mini/mini.surround',
    'https://github.com/nvim-mini/mini.completion',
})


require('vague').setup { transparent = true }
require('monokai-pro').setup { 
	transparent_background = true,
	override_palette = function(filter)
		return {
			dark2 = "#101014",
			dark1 = "#16161E",
			background = "#000000",
			text = "#C0CAF5",
			accent1 = "#f7768e",
			accent2 = "#7aa2f7",
			accent3 = "#e0af68",
			accent4 = "#9ece6a",
			accent5 = "#0DB9D7",
			accent6 = "#9d7cd8",
			dimmed1 = "#737aa2",
			dimmed2 = "#787c99",
			dimmed3 = "#363b54",
			dimmed4 = "#363b54",
			dimmed5 = "#16161e",
		}
	end,
}
vim.cmd.colorscheme('vague')


require('fzf-lua').setup { fzf_colors = true }

require('oil').setup()

require('autoclose').setup()

require('mini.surround').setup()

require('mini.completion').setup()

-- ###
-- LSP
-- ###

vim.lsp.enable({'clangd', 'pyright'})

-- ########
-- KEYBINDS
-- ########

-- Tabs
vim.keymap.set('n', '<C-Tab>', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-S-Tab>', ':tabprevious<CR>', { noremap = true, silent = true })

-- Oil
vim.keymap.set("n", "-", "<cmd>Oil<cr>")

-- FzfLua
vim.keymap.set('n', '<leader>ff', function() require('fzf-lua').files() end)
vim.keymap.set('n', '<leader>fg', function() require('fzf-lua').live_grep() end)
vim.keymap.set('n', '<leader>fh', function() require('fzf-lua').help_tags() end)

-- LSP
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Show line diagnostics" })


