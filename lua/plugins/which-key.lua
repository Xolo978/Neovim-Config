local wk = require("which-key")
wk.setup({
	preset = "modern",

	delay = 250,

	win = {
		border = "rounded",
		padding = {
			1,
			2,
		},
	},

	layout = {
		width = {
			min = 20,
			max = 50,
		},
		spacing = 3,
	},
})

wk.add({
	{ "<leader>b", group = "buffer" },
	{ "<leader>c", group = "code" },
	{ "<leader>d", group = "diagnostics" },
	{ "<leader>f", group = "find" },
	{ "<leader>g", group = "git" },
	{ "<leader>l", group = "LSP" },
	{ "<leader>p", group = "pick" },
	{ "<leader>s", group = "session/search" },
	{ "<leader>t", group = "toggle" },
	{ "<leader>u", group = "UI" },
	{ "<leader>w", group = "window" },
})
