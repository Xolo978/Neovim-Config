local fs = require("filetree.fs")
local icons = require("filetree.icons")
local git = require("filetree.git")

local M = {}
local ns = vim.api.nvim_create_namespace("filetree")

local config = {
	width = 30,
	side = "left",
	filters = {
		dotfiles = false,
		custom = { "^%.git$", "^node_modules$", "^%.DS_Store$" },
	},
	git = { enabled = true },
}

local state = {
	buf = nil,
	win = nil,
	root = nil,
	target_win = nil,
	expanded = {},
	children = {},
	nodes = {},
	show_hidden = false,
	clipboard = {},
}

local function is_open()
	return state.win ~= nil and vim.api.nvim_win_is_valid(state.win)
end

local function is_filtered(name)
	if not state.show_hidden and not config.filters.dotfiles and name:sub(1, 1) == "." then
		return true
	end
	for _, pat in ipairs(config.filters.custom) do
		if name:match(pat) then
			return true
		end
	end
	return false
end

local function get_children(path)
	local cached = state.children[path]
	if cached then
		return cached
	end

	local raw = fs.scandir(path)
	local entries = {}
	for _, e in ipairs(raw) do
		if not is_filtered(e.name) then
			entries[#entries + 1] = e
		end
	end

	state.children[path] = entries
	return entries
end

local function short_root(path)
	local home = (vim.uv or vim.loop).os_homedir()
	if home and path:sub(1, #home) == home then
		return "~" .. path:sub(#home + 1)
	end
	return path
end

local function build()
	local lines = { short_root(state.root) .. "/.." }
	local nodes = { false }
	local marks = {}

	local function walk(path, depth)
		for _, e in ipairs(get_children(path)) do
			local full = path .. "/" .. e.name
			local is_dir = e.type == "directory"
			local indent = string.rep("  ", depth)
			-- caret is always exactly 1 cell wide, whether it's a real glyph
			-- (directories) or a blank placeholder (files) — that's what
			-- keeps icon_start identical for both node types.
			local caret = is_dir and (state.expanded[full] and "▾" or "▸") or " "
			local pre = indent .. caret .. " "
			local icon_start = #pre

			local icon, hl
			if is_dir then
				local is_empty = state.expanded[full] and #get_children(full) == 0
				icon, hl = icons.get_folder_icon(e.name, state.expanded[full], is_empty)
			else
				icon, hl = icons.get_file_icon(e.name)
			end

			local icon_end = icon_start + #icon
			local name_start = icon_end + 1 -- +1 for the space between icon and name
			local name_end = name_start + #e.name

			local line = pre .. icon .. " " .. e.name
			local gcode = config.git.enabled and git.status_for(full) or nil
			local gspec = gcode and git.icon_for(gcode) or nil

			lines[#lines + 1] = line
			nodes[#nodes + 1] = {
				path = full,
				name = e.name,
				type = e.type,
				depth = depth,
				col = icon_start, -- always the first visible glyph, dir or file
			}
			marks[#marks + 1] = {
				line = #lines - 1,
				icon_start = icon_start,
				icon_end = icon_end,
				icon_hl = hl,
				name_start = name_start,
				name_end = name_end,
				name_hl = gspec and gspec.hl or nil,
			}

			if is_dir and state.expanded[full] then
				walk(full, depth + 1)
			end
		end
	end

	walk(state.root, 0)
	state.nodes = nodes
	return lines, marks
end

local function render()
	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
		return
	end

	local lines, marks = build()

	vim.bo[state.buf].modifiable = true
	vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
	vim.api.nvim_buf_clear_namespace(state.buf, ns, 0, -1)

	vim.api.nvim_buf_set_extmark(state.buf, ns, 0, 0, {
		end_col = #lines[1],
		hl_group = "Comment",
	})

	for _, m in ipairs(marks) do
		if m.icon_hl then
			vim.api.nvim_buf_set_extmark(state.buf, ns, m.line, m.icon_start, {
				end_col = m.icon_end,
				hl_group = m.icon_hl,
			})
		end
		-- Git color lives on the name text itself, not a separate badge.
		if m.name_hl then
			vim.api.nvim_buf_set_extmark(state.buf, ns, m.line, m.name_start, {
				end_col = m.name_end,
				hl_group = m.name_hl,
			})
		end
	end

	vim.bo[state.buf].modifiable = false
	vim.bo[state.buf].modified = false
end

local function refresh_git()
	if config.git.enabled and state.root then
		git.refresh(state.root, render)
	end
end

local function node_at(row)
	return state.nodes[row]
end

local function node_at_cursor()
	return node_at(vim.api.nvim_win_get_cursor(state.win)[1])
end

local function toggle_dir(node)
	if node.type ~= "directory" then
		return
	end
	if state.expanded[node.path] then
		state.expanded[node.path] = nil
	else
		state.expanded[node.path] = true
		get_children(node.path)
	end
	render()
end

local function resolve_target_win()
	if state.target_win and vim.api.nvim_win_is_valid(state.target_win) and state.target_win ~= state.win then
		return state.target_win
	end
	for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if w ~= state.win then
			state.target_win = w
			return w
		end
	end
	vim.cmd("vsplit")
	state.target_win = vim.api.nvim_get_current_win()
	return state.target_win
end

local function open_file(path, split)
	local win = resolve_target_win()
	vim.api.nvim_set_current_win(win)

	if split == "vertical" then
		vim.cmd("vsplit " .. vim.fn.fnameescape(path))
	elseif split == "horizontal" then
		vim.cmd("split " .. vim.fn.fnameescape(path))
	elseif split == "tab" then
		vim.cmd("tabedit " .. vim.fn.fnameescape(path))
	else
		vim.cmd("edit " .. vim.fn.fnameescape(path))
	end

	state.target_win = vim.api.nvim_get_current_win()
end

local function on_select(split)
	local node = node_at_cursor()
	if not node then
		return
	end
	if node.type == "directory" then
		toggle_dir(node)
	else
		open_file(node.path, split)
	end
end

local function collapse_or_go_parent()
	local node = node_at_cursor()
	if not node then
		return
	end

	if node.type == "directory" and state.expanded[node.path] then
		state.expanded[node.path] = nil
		render()
		return
	end

	local parent = node.path:match("^(.*)/[^/]+$")
	if not parent then
		return
	end

	for i, n in ipairs(state.nodes) do
		if n and n.path == parent then
			vim.api.nvim_win_set_cursor(state.win, { i, n.col })
			if state.expanded[parent] then
				state.expanded[parent] = nil
				render()
			end
			return
		end
	end
end

local function create()
	local node = node_at_cursor()
	local dir = state.root
	if node then
		dir = node.type == "directory" and node.path or (node.path:match("^(.*)/[^/]+$") or state.root)
	end

	vim.ui.input({ prompt = "New file/dir (end with / for dir): " }, function(input)
		if not input or input == "" then
			return
		end
		local target = dir .. "/" .. input
		if input:sub(-1) == "/" then
			fs.mkdir(target)
		else
			local parent = target:match("^(.*)/[^/]+$")
			if parent and not fs.exists(parent) then
				fs.mkdir(parent)
			end
			fs.touch(target)
		end
		state.children[dir] = nil
		state.expanded[dir] = true
		render()
	end)
end

local function delete_paths(paths)
	if #paths == 0 then
		return
	end
	local label = #paths == 1 and (paths[1]:match("([^/]+)$")) or (#paths .. " items")
	if vim.fn.confirm("Delete " .. label .. "?", "&Yes\n&No", 2) ~= 1 then
		return
	end
	local touched = {}
	for _, p in ipairs(paths) do
		fs.delete(p)
		local parent = p:match("^(.*)/[^/]+$") or state.root
		touched[parent] = true
	end
	for parent in pairs(touched) do
		state.children[parent] = nil
	end
	render()
end

local function delete_node()
	local node = node_at_cursor()
	if node then
		delete_paths({ node.path })
	end
end

local function rename_node()
	local node = node_at_cursor()
	if not node then
		return
	end
	vim.ui.input({ prompt = "Rename: ", default = node.name }, function(input)
		if not input or input == "" or input == node.name then
			return
		end
		local parent = node.path:match("^(.*)/[^/]+$") or state.root
		fs.rename(node.path, parent .. "/" .. input)
		state.children[parent] = nil
		render()
	end)
end

local function mark_clipboard(mode, paths)
	if #paths == 0 then
		return
	end
	state.clipboard = { mode = mode, paths = paths }
	vim.notify(("filetree: marked %d item(s) for %s"):format(#paths, mode == "cut" and "move" or "copy"))
end

local function mark_cut()
	local node = node_at_cursor()
	if node then
		mark_clipboard("cut", { node.path })
	end
end

local function mark_copy()
	local node = node_at_cursor()
	if node then
		mark_clipboard("copy", { node.path })
	end
end

local function visual_range()
	local s = vim.fn.line("v")
	local e = vim.fn.line(".")
	if s > e then
		s, e = e, s
	end
	return s, e
end

local function visual_paths()
	local s, e = visual_range()
	local paths = {}
	for i = s, e do
		local n = node_at(i)
		if n then
			paths[#paths + 1] = n.path
		end
	end
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
	return paths
end

local function paste()
	local clip = state.clipboard
	if not clip.paths or #clip.paths == 0 then
		return
	end

	local node = node_at_cursor()
	local dir = state.root
	if node then
		dir = node.type == "directory" and node.path or (node.path:match("^(.*)/[^/]+$") or state.root)
	end

	for _, src in ipairs(clip.paths) do
		local name = src:match("([^/]+)$")
		local dest = dir .. "/" .. name

		if clip.mode == "cut" then
			fs.rename(src, dest)
			local src_parent = src:match("^(.*)/[^/]+$")
			if src_parent then
				state.children[src_parent] = nil
			end
		else
			fs.copy(src, dest)
		end
	end

	state.children[dir] = nil
	state.clipboard = {}
	render()
end

local function refresh()
	state.children = {}
	render()
	refresh_git()
end

local function toggle_hidden()
	state.show_hidden = not state.show_hidden
	state.children = {}
	render()
end

local function action_menu(target_row)
	local ok, pick = pcall(require, "mini.pick")
	if not ok then
		vim.notify("filetree: mini.pick not found — use a/r/d/x/y/p directly", vim.log.levels.WARN)
		return
	end

	if target_row then
		local n = node_at(target_row)
		vim.api.nvim_win_set_cursor(state.win, { target_row, n and n.col or 0 })
	end

	local node = node_at_cursor()
	local items = {}
	local function add(text, fn)
		items[#items + 1] = { text = text, fn = fn }
	end

	if node then
		add("Open", function()
			on_select()
		end)
		add("Open in vsplit", function()
			on_select("vertical")
		end)
		add("Open in split", function()
			on_select("horizontal")
		end)
		add("Open in tab", function()
			on_select("tab")
		end)
		add("Rename " .. node.name, rename_node)
		add("Delete " .. node.name, delete_node)
		add("Cut " .. node.name, mark_cut)
		add("Copy " .. node.name, mark_copy)
	end
	if state.clipboard.paths and #state.clipboard.paths > 0 then
		add("Paste (" .. #state.clipboard.paths .. " item(s))", paste)
	end
	add("New file/directory", create)
	add("Refresh", refresh)
	add("Toggle hidden files", toggle_hidden)

	pick.start({
		source = {
			items = items,
			name = "Filetree actions",
			choose = function(item)
				if item and item.fn then
					vim.schedule(item.fn)
				end
			end,
		},
	})
end

local function handle_left_click()
	local mouse = vim.fn.getmousepos()
	if mouse.winid ~= state.win or mouse.line < 1 then
		return
	end
	local node = node_at(mouse.line)
	pcall(vim.api.nvim_win_set_cursor, state.win, { mouse.line, node and node.col or 0 })
	on_select()
end

local function handle_right_click()
	local mouse = vim.fn.getmousepos()
	if mouse.winid ~= state.win or mouse.line < 1 then
		return
	end
	action_menu(mouse.line)
end

local function set_win_opts()
	vim.wo[state.win].number = false
	vim.wo[state.win].relativenumber = false
	vim.wo[state.win].signcolumn = "no"
	vim.wo[state.win].foldcolumn = "0"
	vim.wo[state.win].wrap = false
	vim.wo[state.win].winfixwidth = true
	vim.wo[state.win].cursorline = true
	vim.wo[state.win].list = false
	vim.wo[state.win].spell = false
end

local function setup_keymaps()
	local function map(modes, lhs, fn, desc)
		vim.keymap.set(modes, lhs, fn, { buffer = state.buf, nowait = true, silent = true, desc = desc })
	end

	map("n", "<CR>", function()
		on_select()
	end, "Open / expand")
	map("n", "o", function()
		on_select()
	end, "Open / expand")
	map("n", "l", function()
		on_select()
	end, "Open / expand")
	map("n", "h", collapse_or_go_parent, "Collapse / go to parent")
	map("n", "v", function()
		on_select("vertical")
	end, "Open in vsplit")
	map("n", "s", function()
		on_select("horizontal")
	end, "Open in split")
	map("n", "t", function()
		on_select("tab")
	end, "Open in tab")
	map("n", "a", create, "Create file/dir")
	map("n", "d", delete_node, "Delete")
	map("n", "r", rename_node, "Rename")
	map("n", "x", mark_cut, "Cut")
	map("n", "y", mark_copy, "Copy")
	map("n", "p", paste, "Paste")
	map("n", "R", refresh, "Refresh")
	map("n", "H", toggle_hidden, "Toggle hidden files")
	map("n", "m", function()
		action_menu()
	end, "Action menu (mini.pick)")
	map("n", "q", M.close, "Close")
	map("n", "<Esc>", M.close, "Close")

	map("x", "x", function()
		mark_clipboard("cut", visual_paths())
	end, "Cut selection")
	map("x", "y", function()
		mark_clipboard("copy", visual_paths())
	end, "Copy selection")
	map("x", "d", function()
		delete_paths(visual_paths())
	end, "Delete selection")

	map("n", "<LeftMouse>", handle_left_click, "Open / expand (click)")
	map("n", "<2-LeftMouse>", handle_left_click, "Open / expand (double click)")
	map("n", "<RightMouse>", handle_right_click, "Action menu (right click)")
end

function M.close()
	if is_open() then
		vim.api.nvim_win_close(state.win, true)
	end
	state.win = nil
end

function M.open(path)
	if is_open() then
		return
	end

	state.root = path and vim.fn.fnamemodify(path, ":p"):gsub("/$", "") or ((vim.uv or vim.loop).cwd())
	if state.root == "" then
		state.root = "/"
	end
	state.target_win = vim.api.nvim_get_current_win()

	local pos = config.side == "right" and "botright" or "topleft"
	vim.cmd(pos .. " vertical " .. config.width .. "split")
	state.win = vim.api.nvim_get_current_win()

	state.buf = vim.api.nvim_create_buf(false, true)
	vim.bo[state.buf].buftype = "nofile"
	vim.bo[state.buf].bufhidden = "wipe"
	vim.bo[state.buf].swapfile = false
	vim.bo[state.buf].filetype = "filetree"
	pcall(vim.api.nvim_buf_set_name, state.buf, "filetree://" .. state.root)

	vim.api.nvim_win_set_buf(state.win, state.buf)
	set_win_opts()
	setup_keymaps()
	render()
	refresh_git()
end

function M.toggle()
	if not is_open() then
		M.open()
		return
	end
	if vim.api.nvim_get_current_win() == state.win then
		M.close()
	else
		vim.api.nvim_set_current_win(state.win)
	end
end

function M.refresh()
	refresh()
end

function M.setup(opts)
	config = vim.tbl_deep_extend("force", config, opts or {})

	vim.api.nvim_create_autocmd("WinClosed", {
		group = vim.api.nvim_create_augroup("filetree_win_closed", { clear = true }),
		callback = function(args)
			if tonumber(args.match) == state.win then
				state.win = nil
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufEnter", {
		group = vim.api.nvim_create_augroup("filetree_auto_close", { clear = true }),
		callback = function()
			if
				is_open()
				and #vim.api.nvim_tabpage_list_wins(0) == 1
				and vim.api.nvim_get_current_buf() == state.buf
			then
				vim.cmd("qa")
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = vim.api.nvim_create_augroup("filetree_git_refresh", { clear = true }),
		callback = function()
			if is_open() then
				refresh_git()
			end
		end,
	})

	vim.api.nvim_create_autocmd({ "FocusGained", "WinEnter" }, {
		group = vim.api.nvim_create_augroup("filetree_git_focus_refresh", { clear = true }),
		callback = function()
			if is_open() and vim.api.nvim_get_current_buf() == state.buf then
				refresh_git()
			end
		end,
	})
end

return M
