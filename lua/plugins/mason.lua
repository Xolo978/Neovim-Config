require("mason").setup({
	ui = {
		border = "rounded",
	},
	registry = {
		refresh = false,
	},
})

require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"clangd",
		"basedpyright",
		"bashls",
		"jsonls",
		"marksman",
		"rust_analyzer",
	},

	automatic_enable = true,
})

local registry = require("mason-registry")

local function ensure_package(name)
	local ok, package = pcall(registry.get_package, name)

	if not ok then
		vim.notify("Mason package not found: " .. name, vim.log.levels.WARN)
		return
	end

	if not package:is_installed() then
		package:install()
	end
end

vim.schedule(function()
	for _, package in ipairs({
		"stylua",
		"clang-format",
		"shfmt",
		"prettier",
	}) do
		ensure_package(package)
	end
end)
