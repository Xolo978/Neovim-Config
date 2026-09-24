local flash = require("flash")

flash.setup({
	labels = "asdfghjklqwertyuiopzxcvbnm",

	modes = {
		search = {
			enabled = true,
		},

		char = {
			enabled = true,
			jump_labels = true,
			multi_line = true,
		},
	},

	search = {
		mode = "exact",

		exclude = {
			"notify",
			"cmp_menu",
			"noice",
			"flash_prompt",
			"flash_search",
		},
	},

	prompt = {
		enabled = true,

		prefix = {
			{ " ⚡ ", "FlashPromptIcon" },
		},

		win_config = {
			relative = "editor",
			border = "rounded",
			row = -3,
			col = 0,
			width = 20,
			height = 1,
			zindex = 1000,
		},
	},

	label = {
		uppercase = false,

		rainbow = {
			enabled = true,
			shade = 5,
		},
	},

	highlight = {
		backdrop = true,
		matches = true,
	},

	jump = {
		jumplist = true,
		history = true,
		register = true,
		noselect = false,
		autojump = false,
	},

	remote_op = {
		restore = true,
		motion = true,
	},
})
