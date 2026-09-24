vim.pack.add({
	-- Existing completion/LSP plugins.
	{
		src = "https://github.com/saghen/blink.lib",
		version = "main",
	},
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	{
		src = "https://github.com/nvim-lua/plenary.nvim",
	},
	{
		src = "https://github.com/MunifTanjim/nui.nvim",
	},
	{
		src = "https://github.com/nvim-tree/nvim-web-devicons",
	},
	{
		src = "https://github.com/Saghen/blink.cmp",
		version = "main",
	},
	{
		src = "https://github.com/mason-org/mason.nvim",
		version = "main",
	},
	{
		src = "https://github.com/mason-org/mason-lspconfig.nvim",
		version = "main",
	},
	{
		src = "https://github.com/neovim/nvim-lspconfig",
		version = "master",
	},

	-- UI and editing.
	{
		src = "https://github.com/nvim-mini/mini.nvim",
		version = "main",
	},
	{
		src = "https://github.com/folke/which-key.nvim",
		version = "main",
	},
	{
		src = "https://github.com/stevearc/oil.nvim",
		version = "master",
	},
	{
		src = "https://github.com/stevearc/conform.nvim",
		version = "master",
	},
	{
		src = "https://github.com/folke/flash.nvim",
		version = "main",
	},
}, {
	confirm = false,
	load = false,
})

vim.cmd.packadd("blink.lib")
vim.cmd.packadd("blink.cmp")
vim.cmd.packadd("mason.nvim")
vim.cmd.packadd("mason-lspconfig.nvim")
vim.cmd.packadd("nvim-lspconfig")
vim.cmd.packadd("mini.nvim")
vim.cmd.packadd("flash.nvim")

vim.cmd.packadd("neo-tree.nvim")
vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("nui.nvim")
vim.cmd.packadd("nvim-web-devicons")

vim.cmd.packadd("oil.nvim")

require("plugins.blink")
require("plugins.neo-tree")
require("plugins.mason")
require("plugins.mini")
require("plugins.oil")
require("plugins.flash")
require("plugins.which-key")
require("plugins.conform")
