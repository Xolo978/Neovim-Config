require("filetree").setup({
	width = 30,
	side = "left",
	filters = {
		dotfiles = false,
		custom = { "^%.git$", "^node_modules$", "^%.DS_Store$" },
	},
})
