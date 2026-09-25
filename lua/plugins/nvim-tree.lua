require("nvim-tree").setup({
	disable_netrw = true,
	hijack_netrw = true,

	view = {
		side = "left",
		width = 34,
	},

	update_focused_file = {
		enable = true,
		update_root = {
			enable = false,
		},
	},

	git = {
		enable = true,
	},

	diagnostics = {
		enable = true,
	},

	filters = {
		dotfiles = false,
		git_ignored = false,
		custom = {
			"^%.git$",
			"^%.DS_Store$",
			"^thumbs%.db$",
		},
	},

	renderer = {
		icons = {
			glyphs = {
				default = "",
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
				},
				git = {
					unstaged = "󰄱",
					staged = "󰱒",
					unmerged = "",
					renamed = "󰁕",
					untracked = "",
					deleted = "✖",
					ignored = "",
				},
			},
		},
	},
})
