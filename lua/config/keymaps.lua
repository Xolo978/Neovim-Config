local map = vim.keymap.set
local del = vim.keymap.del

local silent = {
	noremap = true,
	silent = true,
}

for _, lhs in ipairs({
	"<leader>e",
	"<leader>E",
	"<leader>o",
	"<leader>O",
}) do
	pcall(del, "n", lhs)
end

map("n", "<M-w>", "<cmd>write<cr>", {
	desc = "Save file",
})

map("i", "<M-w>", "<Esc><cmd>write<cr>", {
	desc = "Save file",
})

map("n", "<M-q>", "<cmd>confirm quit<cr>", {
	desc = "Quit window",
})

map("i", "<M-q>", "<Esc><cmd>confirm quit<cr>", {
	desc = "Quit window",
})

map("n", "<M-Q>", "<cmd>confirm qall<cr>", {
	desc = "Quit Neovim",
})

map("n", "<leader>w", "<cmd>write<cr>", {
	desc = "Save file",
})

map("n", "<leader>W", "<cmd>wall<cr>", {
	desc = "Save all files",
})

map("n", "<leader>x", "<cmd>confirm bdelete<cr>", {
	desc = "Close buffer",
})

map("n", "<leader>?", function()
	require("which-key").show({
		global = false,
	})
end, {
	desc = "Show keymaps",
})

local function find_minifiles_window()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(win) then
			local buf = vim.api.nvim_win_get_buf(win)

			if vim.bo[buf].filetype == "minifiles" then
				return win
			end
		end
	end

	return nil
end

local function minifiles_anchor_path()
	local current_file = vim.api.nvim_buf_get_name(0)

	if current_file ~= "" then
		return current_file
	end

	return vim.uv.cwd() or vim.fn.getcwd()
end

local function toggle_minifiles(side)
	local mini_files = require("mini.files")
	local mini_files_window = find_minifiles_window()

	if mini_files_window then
		vim.api.nvim_win_call(mini_files_window, mini_files.close)
		return
	end

	local target_window = vim.api.nvim_get_current_win()

	mini_files.open(minifiles_anchor_path(), true)
	mini_files.set_target_window(target_window)

	-- mini.files uses floating column windows; this keeps the old left/right
	-- intent as closely as possible when placing the focused explorer column.
	local opened_window = find_minifiles_window()

	if opened_window then
		vim.api.nvim_win_call(opened_window, function()
			vim.cmd.wincmd(side == "right" and "L" or "H")
		end)
	end
end

map("n", "<leader>e", function()
	toggle_minifiles("left")
end, {
	desc = "Toggle MiniFiles",
})

map("n", "<leader>E", function()
	toggle_minifiles("right")
end, {
	desc = "Toggle MiniFiles right",
})

local function find_oil_window()
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		if vim.api.nvim_win_is_valid(win) then
			local buf = vim.api.nvim_win_get_buf(win)

			if vim.bo[buf].filetype == "oil" then
				return win
			end
		end
	end

	return nil
end

map({ "n", "x" }, "s", function()
	require("flash").jump()
end, {
	desc = "Flash jump",
})

map("n", "<leader>o", function()
	local oil = require("oil")
	local oil_window = find_oil_window()

	if oil_window then
		vim.api.nvim_win_call(oil_window, function()
			oil.close()
		end)

		return
	end

	local cwd = vim.fn.getcwd()
	vim.cmd("Oil " .. vim.fn.fnameescape(cwd))
end, {
	desc = "Toggle Oil",
})

map("n", "<leader>O", function()
	local oil = require("oil")
	local current_buf = vim.api.nvim_get_current_buf()

	if vim.bo[current_buf].filetype == "oil" then
		oil.close()
		return
	end

	local cwd = vim.fn.getcwd()
	vim.cmd("Oil --float " .. vim.fn.fnameescape(cwd))
end, {
	desc = "Toggle floating Oil",
})

map("n", "<leader>ff", function()
	require("mini.pick").builtin.files()
end, {
	desc = "Find files",
})

map("n", "<leader>fb", function()
	require("mini.pick").builtin.buffers()
end, {
	desc = "Find buffers",
})

map("n", "<leader>fg", function()
	require("mini.pick").builtin.grep_live()
end, {
	desc = "Live grep",
})

map("n", "<leader>fh", function()
	require("mini.pick").builtin.help()
end, {
	desc = "Find help",
})

map("n", "<leader>fr", function()
	require("mini.pick").builtin.resume()
end, {
	desc = "Resume picker",
})

map("n", "<leader>fd", vim.diagnostic.setloclist, {
	desc = "Diagnostics to location list",
})

map("n", "<leader>ca", vim.lsp.buf.code_action, {
	desc = "Code action / auto-fix",
})

map("n", "<leader>ct", vim.lsp.buf.type_definition, {
	desc = "Go to type definition",
})

map("n", "<leader>cr", vim.lsp.buf.references, {
	desc = "Show references",
})

map("n", "<leader>ci", vim.lsp.buf.implementation, {
	desc = "Go to implementation",
})

map("n", "<leader>cD", vim.lsp.buf.declaration, {
	desc = "Go to declaration",
})

map("n", "<leader>rn", vim.lsp.buf.rename, {
	desc = "Rename symbol",
})

map("n", "<leader>cd", function()
	vim.diagnostic.open_float(nil, {
		border = "rounded",
		focus = true,
		scope = "line",
	})
end, {
	desc = "Show line diagnostic",
})

map("n", "<leader>li", "<cmd>LspInfo<cr>", {
	desc = "LSP information",
})

map("n", "<leader>ll", "<cmd>LspLog<cr>", {
	desc = "LSP log",
})

map("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		float = true,
	})
end, {
	desc = "Previous diagnostic",
})

map("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		float = true,
	})
end, {
	desc = "Next diagnostic",
})

map("n", "<leader>dq", vim.diagnostic.setloclist, {
	desc = "Diagnostics to location list",
})

map({ "n", "v" }, "<leader>lf", "<cmd>Format<cr>", {
	desc = "Format buffer",
})

map("n", "<leader>tf", "<cmd>FormatDisable<cr>", {
	desc = "Disable format-on-save",
})

map("n", "<leader>tF", "<cmd>FormatEnable<cr>", {
	desc = "Enable format-on-save",
})

map("n", "[q", "<cmd>cprevious<cr>", {
	desc = "Previous quickfix item",
})

map("n", "]q", "<cmd>cnext<cr>", {
	desc = "Next quickfix item",
})

map("n", "<leader>qo", "<cmd>copen<cr>", {
	desc = "Open quickfix",
})

map("n", "<leader>qc", "<cmd>cclose<cr>", {
	desc = "Close quickfix",
})

map("n", "<C-h>", "<C-w>h", {
	desc = "Move to left window",
})

map("n", "<C-j>", "<C-w>j", {
	desc = "Move to lower window",
})

map("n", "<C-k>", "<C-w>k", {
	desc = "Move to upper window",
})

map("n", "<C-l>", "<C-w>l", {
	desc = "Move to right window",
})

map("n", "<leader>ww", "<C-w>w", {
	desc = "Cycle windows",
})

map("n", "<leader>ws", "<cmd>split<cr>", {
	desc = "Split below",
})

map("n", "<leader>wv", "<cmd>vsplit<cr>", {
	desc = "Split right",
})

map("n", "<leader>wc", "<cmd>close<cr>", {
	desc = "Close window",
})

map("n", "<M-Up>", "<cmd>resize +2<cr>", {
	desc = "Increase window height",
})

map("n", "<M-Down>", "<cmd>resize -2<cr>", {
	desc = "Decrease window height",
})

map("n", "<M-Left>", "<cmd>vertical resize -2<cr>", {
	desc = "Decrease window width",
})

map("n", "<M-Right>", "<cmd>vertical resize +2<cr>", {
	desc = "Increase window width",
})

map("n", "<Tab>", "<cmd>bnext<cr>", {
	desc = "Next buffer",
})

map("n", "<S-Tab>", "<cmd>bprevious<cr>", {
	desc = "Previous buffer",
})

map("n", "<leader>bd", function()
	local bufnr = vim.api.nvim_get_current_buf()

	if vim.bo[bufnr].modified then
		local choice = vim.fn.confirm("Save changes before closing?", "&Yes\n&No\n&Cancel", 1)

		if choice == 1 then
			vim.cmd.write()
		elseif choice == 3 then
			return
		end
	end

	vim.cmd.bdelete(bufnr)
end, {
	desc = "Close current buffer",
})

map("n", "<leader>ba", "<cmd>enew<cr>", {
	desc = "Create new buffer",
})

map("n", "<leader>bb", "<cmd>buffer #<cr>", {
	desc = "Switch to alternate buffer",
})

map("n", "<leader>bl", "<cmd>buffers<cr>", {
	desc = "List buffers",
})

local function close_current_buffer()
	local current = vim.api.nvim_get_current_buf()

	-- Ask before closing unsaved changes.
	if vim.bo[current].modified then
		local choice = vim.fn.confirm("Save changes before closing?", "&Yes\n&No\n&Cancel", 1)

		if choice == 1 then
			vim.cmd.write()
		elseif choice == 3 then
			return
		end
	end

	local listed_buffers = {}

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted then
			table.insert(listed_buffers, bufnr)
		end
	end

	-- If this is the last listed buffer, create a hidden replacement buffer
	-- so Neovim always has somewhere to display the current window.
	if #listed_buffers <= 1 then
		vim.cmd.enew()

		local replacement = vim.api.nvim_get_current_buf()
		vim.bo[replacement].buflisted = false
		vim.bo[replacement].bufhidden = "wipe"
		vim.bo[replacement].swapfile = false
		vim.bo[replacement].modified = false

		if current ~= replacement and vim.api.nvim_buf_is_valid(current) then
			pcall(vim.api.nvim_buf_delete, current, {
				force = true,
			})
		end

		return
	end

	vim.cmd("bdelete " .. current)
end

map("n", "<leader>bd", close_current_buffer, {
	desc = "Close current buffer",
})

map("n", "<leader>ut", function()
	vim.opt.list = not vim.opt.list:get()
end, {
	desc = "Toggle whitespace",
})

map("n", "<leader>uw", function()
	vim.opt.wrap = not vim.opt.wrap:get()
end, {
	desc = "Toggle wrap",
})

map("n", "<leader>un", function()
	vim.opt.number = not vim.opt.number:get()
	vim.opt.relativenumber = not vim.opt.relativenumber:get()
end, {
	desc = "Toggle line numbers",
})

map("n", "<Esc>", "<cmd>nohlsearch<cr>", {
	desc = "Clear search highlighting",
})

map("n", "<C-d>", "<C-d>zz", {
	desc = "Scroll down and center",
})

map("n", "<C-u>", "<C-u>zz", {
	desc = "Scroll up and center",
})

map("n", "n", "nzzzv", {
	desc = "Next search result",
})

map("n", "N", "Nzzzv", {
	desc = "Previous search result",
})

map("v", "J", ":m '>+1<CR>gv=gv", {
	desc = "Move selection down",
})

map("v", "K", ":m '<-2<CR>gv=gv", {
	desc = "Move selection up",
})

map("v", "<", "<gv", {
	desc = "Indent selection left",
})

map("v", ">", ">gv", {
	desc = "Indent selection right",
})

map("x", "<leader>p", [["_dP]], {
	desc = "Paste without replacing register",
})

map({ "n", "v" }, "<leader>y", [["+y]], {
	desc = "Yank to system clipboard",
})

map({ "n", "v" }, "<leader>d", [["_d]], {
	desc = "Delete without replacing register",
})

map("t", "<Esc><Esc>", "<C-\\><C-n>", {
	desc = "Exit terminal mode",
})
