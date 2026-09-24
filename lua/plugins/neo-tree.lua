require("neo-tree").setup({
	close_if_last_window = false,

	popup_border_style = "rounded",

	enable_git_status = true,
	enable_diagnostics = true,

	filesystem = {
		bind_to_cwd = true,
		follow_current_file = {
			enabled = true,
			leave_dirs_open = false,
		},

		hijack_netrw_behavior = "open_default",

		filtered_items = {
			visible = true,
			hide_dotfiles = false,
			hide_gitignored = false,
			hide_by_name = {
				".git",
				".DS_Store",
				"thumbs.db",
			},
		},

		use_libuv_file_watcher = true,
	},

	window = {
		position = "left",
		width = 34,

		mappings = {
			["<space>"] = "none",

			["l"] = "open",
			["<Right>"] = "open",

			["h"] = "navigate_up",
			["<Left>"] = "navigate_up",

			["<CR>"] = "open",
			["o"] = "open",

			["s"] = "open_vsplit",
			["S"] = "open_split",
			["t"] = "open_tabnew",

			["q"] = "close_window",
			["R"] = "refresh",
			["?"] = "show_help",
			["H"] = "toggle_hidden",
		},
	},
	default_component_configs = {
		indent = {
			padding = 1,
			with_expanders = true,
			expander_collapsed = "",
			expander_expanded = "",
			expander_highlight = "NeoTreeExpander",
		},

		icon = {
			folder_closed = "",
			folder_open = "",
			folder_empty = "",
			default = "",
		},

		git_status = {
			symbols = {
				added = "✚",
				modified = "",
				deleted = "✖",
				renamed = "󰁕",
				untracked = "",
				ignored = "",
				unstaged = "󰄱",
				staged = "󰱒",
				conflict = "",
			},
		},
	},
})
