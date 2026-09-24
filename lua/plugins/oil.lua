require("oil").setup({
	default_file_explorer = false,

	columns = {
		"icon",
		"permissions",
		"size",
		"mtime",
	},

	delete_to_trash = true,
	skip_confirm_for_simple_edits = true,

	view_options = {
		show_hidden = true,
		natural_order = true,
		case_insensitive = false,
	},

	float = {
		padding = 2,
		max_width = 0.9,
		max_height = 0.8,
		border = "rounded",
	},

	keymaps = {
		["g?"] = {
			"actions.show_help",
			mode = "n",
		},

		["<CR>"] = "actions.select",
		["<C-s>"] = {
			"actions.select",
			opts = {
				vertical = true,
			},
		},

		["<C-h>"] = {
			"actions.select",
			opts = {
				horizontal = true,
			},
		},

		["<C-t>"] = {
			"actions.select",
			opts = {
				tab = true,
			},
		},

		["<C-p>"] = "actions.preview",
		["<C-c>"] = {
			"actions.close",
			mode = "n",
		},

		["<BS>"] = {
			"actions.parent",
			mode = "n",
			desc = "Go to parent directory",
		},

		["-"] = {
			"actions.parent",
			mode = "n",
			desc = "Go to parent directory",
		},

		["_"] = {
			"actions.open_cwd",
			mode = "n",
			desc = "Open current working directory",
		},

		["g."] = {
			"actions.toggle_hidden",
			mode = "n",
			desc = "Toggle hidden files",
		},

		["gx"] = "actions.open_external",
	},
})
