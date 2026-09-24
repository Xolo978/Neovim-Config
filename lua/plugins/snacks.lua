local Snacks = require("snacks")

local function open_files()
	Snacks.dashboard.pick("files")
end

local function live_grep()
	Snacks.dashboard.pick("live_grep")
end

local function open_recent()
	Snacks.dashboard.pick("oldfiles")
end

local function new_file()
	vim.cmd("enew")
end

local function quit()
	vim.cmd("qa")
end

local session_section = Snacks.dashboard.sections.session({
	icon = "   ",
	title = "Session",
	padding = 1,
})

Snacks.setup({
	dashboard = {
		enabled = true,

		width = 72,
		row = nil,
		col = nil,
		pane_gap = 4,

		preset = {
			header = [[
     ╭──────────────────────────────────────────────╮
     │                   N E O V I M                │
     ╰──────────────────────────────────────────────╯
      ]],

			keys = {
				{
					icon = "   ",
					key = "f",
					desc = "Find files",
					action = open_files,
				},
				{
					icon = "   ",
					key = "g",
					desc = "Search project",
					action = live_grep,
				},
				{
					icon = "   ",
					key = "r",
					desc = "Recent files",
					action = open_recent,
				},
				{
					icon = "   ",
					key = "s",
					desc = "Load session",
					section = "session",
				},
				{
					icon = "   ",
					key = "n",
					desc = "New buffer",
					action = new_file,
				},
				{
					icon = "   ",
					key = "q",
					desc = "Quit",
					action = quit,
				},
			},
		},

		sections = {
			{
				section = "header",
				padding = 1,
			},

			{
				section = "keys",
				gap = 1,
				padding = 1,
			},

			session_section,

			{
				section = "startup",
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
end, {
	desc = "Toggle profiler",
})

vim.keymap.set("n", "<leader>ps", function()
	Snacks.profiler.scratch()
end, {
	desc = "Profiler scratch",
})

vim.keymap.set("n", "<leader>ph", function()
	Snacks.profiler.highlight()
end, {
	desc = "Toggle profiler highlights",
})

vim.keymap.set("n", "<leader>dd", function()
	Snacks.dashboard.open()
end, {
	desc = "Open dashboard",
})

