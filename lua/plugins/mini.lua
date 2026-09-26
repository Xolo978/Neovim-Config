require("mini.icons").setup({
	style = "glyph",
})

require("mini.pairs").setup({
	modes = {
		insert = true,
		command = false,
		terminal = false,
	},
})

-- require("mini.surround").setup({
-- 	mappings = {
-- 		add = "gsa",
-- 		delete = "gsd",
-- 		find = "gsf",
-- 		find_left = "gsF",
-- 		highlight = "gsh",
-- 		replace = "gsr",
-- 		update_n_lines = "gsn",
-- 	},
-- })

require("mini.tabline").setup({
	-- Use mini.tabline's built-in formatter.
	show_icons = true,
	format = nil,

	-- Do not show Neovim tabpage information in the buffer bar.
	tabpage_section = "none",
})

require("mini.comment").setup({
	mappings = {
		comment = "gc",
		comment_line = "gcc",
		comment_visual = "gc",
		textobject = "gc",
	},
})

require("mini.pick").setup({
	delay = {
		busy = 25,
	},

	mappings = {
		choose = "<CR>",
		choose_in_split = "<C-s>",
		choose_in_tabpage = "<C-t>",
		choose_in_vsplit = "<C-v>",
		stop = "<Esc>",
		scroll_down = "<C-f>",
		scroll_up = "<C-b>",
	},
})

require("mini.sessions").setup({
	directory = vim.fn.stdpath("state") .. "/sessions",

	autoread = false,
	autowrite = true,

	file = "",

	force = {
		read = false,
		write = true,
		delete = false,
	},
})
