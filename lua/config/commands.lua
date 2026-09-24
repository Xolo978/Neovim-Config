local api = vim.api

-- Reload the current Neovim configuration.
vim.api.nvim_create_user_command("ReloadConfig", function()
	local config_file = vim.env.MYVIMRC or api.nvim_get_runtime_file("init.lua", false)[1]

	if not config_file then
		vim.notify("Could not find init.lua", vim.log.levels.ERROR)
		return
	end

	local ok, err = pcall(vim.cmd.source, vim.fn.fnameescape(config_file))

	if ok then
		vim.notify("Neovim configuration reloaded", vim.log.levels.INFO)
	else
		vim.notify("Failed to reload config:\n" .. err, vim.log.levels.ERROR)
	end
end, {
	desc = "Reload Neovim configuration",
})

local function session_name()
	local cwd = vim.fn.getcwd()
	local name = vim.fn.fnamemodify(cwd, ":t")

	if name == "" then
		name = "default"
	end

	return name
end

vim.api.nvim_create_user_command("SessionSave", function(args)
	local name = args.args ~= "" and args.args or session_name()
	require("mini.sessions").write(name)
end, {
	nargs = "?",
	desc = "Save a Mini Session",
})

vim.api.nvim_create_user_command("SessionLoad", function(args)
	if args.args == "" then
		vim.notify("Usage: :SessionLoad {name}", vim.log.levels.WARN)
		return
	end

	require("mini.sessions").read(args.args)
end, {
	nargs = 1,
	complete = function()
		local sessions = require("mini.sessions").detected
		local names = {}

		for name in pairs(sessions) do
			table.insert(names, name)
		end

		table.sort(names)
		return names
	end,
	desc = "Load a Mini Session",
})

vim.api.nvim_create_user_command("SessionDelete", function(args)
	if args.args == "" then
		vim.notify("Usage: :SessionDelete {name}", vim.log.levels.WARN)
		return
	end

	require("mini.sessions").delete(args.args)
end, {
	nargs = 1,
	complete = function()
		local sessions = require("mini.sessions").detected
		local names = {}

		for name in pairs(sessions) do
			table.insert(names, name)
		end

		table.sort(names)
		return names
	end,
	desc = "Delete a Mini Session",
})

-- Open a scratch buffer.
vim.api.nvim_create_user_command("Scratch", function()
	vim.cmd("enew")

	vim.bo.buftype = "nofile"
	vim.bo.bufhidden = "wipe"
	vim.bo.swapfile = false
	vim.bo.filetype = "scratch"

	vim.api.nvim_buf_set_name(0, "scratch://" .. os.date("%Y-%m-%d-%H-%M-%S"))
end, {
	desc = "Open a scratch buffer",
})

-- Remove trailing whitespace manually.
vim.api.nvim_create_user_command("TrimWhitespace", function()
	local view = vim.fn.winsaveview()

	vim.cmd([[
    silent! keepjumps keeppatterns %s/\s\+$//e
  ]])

	vim.fn.winrestview(view)
	vim.notify("Trailing whitespace removed", vim.log.levels.INFO)
end, {
	desc = "Remove trailing whitespace",
})

-- Format using the first attached LSP client that supports formatting.
vim.api.nvim_create_user_command("Format", function()
	local clients = vim.lsp.get_clients({
		bufnr = 0,
	})

	for _, client in ipairs(clients) do
		if client:supports_method("textDocument/formatting") then
			vim.lsp.buf.format({
				async = true,
				timeout_ms = 3000,
			})
			return
		end
	end

	vim.notify("No attached LSP supports formatting", vim.log.levels.WARN)
end, {
	desc = "Format current buffer with LSP",
})

-- Toggle diagnostics.
vim.api.nvim_create_user_command("DiagnosticsToggle", function()
	local enabled = vim.diagnostic.is_enabled()

	vim.diagnostic.enable(not enabled)

	vim.notify(enabled and "Diagnostics disabled" or "Diagnostics enabled", vim.log.levels.INFO)
end, {
	desc = "Toggle diagnostics",
})

-- Show the current file path.
vim.api.nvim_create_user_command("FilePath", function()
	local path = vim.fn.expand("%:p")

	if path == "" then
		vim.notify("Current buffer has no file path", vim.log.levels.WARN)
		return
	end

	vim.notify(path, vim.log.levels.INFO)
end, {
	desc = "Show current file path",
})
