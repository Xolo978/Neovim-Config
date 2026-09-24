vim.pack.add({
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
	{
		src = "https://github.com/catppuccin/nvim",
		name = "catppuccin",
	},
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
	{
		src = "https://github.com/folke/snacks.nvim",
	},
}, {
	confirm = false,
	load = false,
})

-- Core dependencies

vim.cmd.packadd("plenary.nvim")
vim.cmd.packadd("nui.nvim")
vim.cmd.packadd("nvim-web-devicons")

vim.cmd.packadd("catppuccin")
vim.cmd.packadd("mini.nvim")

require("plugins.catppuccin")
require("plugins.mini")
require("plugins.statusline")

-- Completion

vim.cmd.packadd("blink.lib")
vim.cmd.packadd("blink.cmp")

require("plugins.blink")

-- LSP

vim.cmd.packadd("nvim-lspconfig")
require("lsp")

-- Deferred plugins

local deferred_loaded = false

local function load_deferred_plugins()
	if deferred_loaded then
		return
	end

	deferred_loaded = true

	vim.cmd.packadd("snacks.nvim")
	require("plugins.snacks")

	vim.cmd.packadd("mason.nvim")
	vim.cmd.packadd("mason-lspconfig.nvim")

	vim.cmd.packadd("flash.nvim")
	vim.cmd.packadd("neo-tree.nvim")
	vim.cmd.packadd("oil.nvim")
	vim.cmd.packadd("which-key.nvim")
	vim.cmd.packadd("conform.nvim")

	require("plugins.mason")
	require("plugins.flash")
	require("plugins.neo-tree")
	require("plugins.oil")
	require("plugins.which-key")
	require("plugins.conform")

	if vim.fn.argc() == 0 and vim.api.nvim_buf_get_name(0) == "" and vim.bo.buftype == "" and not vim.bo.modified then
		vim.schedule(function()
			require("snacks").dashboard.open()
		end)
	end
end

vim.api.nvim_create_autocmd("UIEnter", {
	once = true,
	callback = function()
		vim.schedule(load_deferred_plugins)
	end,
})

-- Snacks is profiler-only.

if vim.env.PROF then
	vim.cmd.packadd("snacks.nvim")
	require("plugins.snacks")
end
