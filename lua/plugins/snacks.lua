local Snacks = require("snacks")

Snacks.setup({
	dashboard = {
		enabled = true,

		width = 60,
		row = nil,
		col = nil,
		pane_gap = 10,

		preset = {
			header = [[
██████╗ ███████╗██╗   ██╗██╗███╗   ███╗
██╔══██╗██╔════╝██║   ██║██║████╗ ████║
██║  ██║█████╗  ██║   ██║██║██╔████╔██║
██║  ██║██╔══╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
██████╔╝███████╗ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═════╝ ╚══════╝  ╚═══╝  ╚═╝╚═╝     ╚═╝]],

			keys = {
				{ icon = " ", key = "f", desc = "Find files", action = ":lua Snacks.dashboard.pick('files')" },
				{ icon = " ", key = "g", desc = "Search project", action = ":lua Snacks.dashboard.pick('live_grep')" },
				{ icon = " ", key = "r", desc = "Recent files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
				{ icon = " ", key = "s", desc = "Load session", section = "session" },
				{ icon = " ", key = "n", desc = "New buffer", action = ":ene | startinsert" },
				{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
			},
		},

		sections = {
			-- left pane
			{ section = "header", padding = 1 },
			{ section = "keys", gap = 1, padding = 1 },
			{
				section = "session",
				icon = " ",
				title = "Session",
				padding = 1,
			},
			-- right pane
			{
				pane = 2,
				icon = " ",
				title = "Recent Files",
				section = "recent_files",
				indent = 2,
				padding = 1,
			},
			{
				pane = 2,
				icon = " ",
				title = "Projects",
				section = "projects",
				indent = 2,
				padding = 1,
			},
		},
	},

	profiler = {
		on_stop = {
			highlights = true,
			pick = true,
		},

		startup = {
			event = "VimEnter",
			after = true,
			pick = true,
		},

		presets = {
			startup = {
				min_time = 1,
				sort = false,
			},

			on_stop = {
				min_time = 1,
				sort = true,
			},
		},
	},
})

vim.keymap.set("n", "<leader>pp", function()
	Snacks.profiler.toggle()
end, { desc = "Toggle profiler" })

vim.keymap.set("n", "<leader>ps", function()
	Snacks.profiler.scratch()
end, { desc = "Profiler scratch" })

vim.keymap.set("n", "<leader>ph", function()
	Snacks.profiler.highlight()
end, { desc = "Toggle profiler highlights" })

vim.keymap.set("n", "<leader>dd", function()
	Snacks.dashboard.open()
end, { desc = "Open dashboard" })
