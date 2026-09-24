local statusline = require("mini.statusline")

local active = function()
	local mode, mode_hl = statusline.section_mode({
		trunc_width = 80,
	})

	local git = statusline.section_git({
		trunc_width = 55,
	})

	local diff = statusline.section_diff({
		trunc_width = 75,
	})

	local diagnostics = statusline.section_diagnostics({
		trunc_width = 75,
		signs = {
			ERROR = "󰅚 ",
			WARN = "󰀪 ",
			INFO = "󰋽 ",
			HINT = "󰌶 ",
		},
	})

	local lsp = statusline.section_lsp({
		trunc_width = 75,
	})

	local filename = statusline.section_filename({
		trunc_width = 140,
	})

	local fileinfo = statusline.section_fileinfo({
		trunc_width = 100,
	})

	local search = statusline.section_searchcount({
		trunc_width = 75,
	})

	local location = statusline.section_location({
		trunc_width = 75,
	})

	return statusline.combine_groups({
		{
			hl = mode_hl,
			strings = { " " .. mode .. " " },
		},

		{
			hl = "MiniStatuslineDevinfo",
			strings = {
				git,
				diff,
				diagnostics,
				lsp,
			},
		},

		"%<",

		{
			hl = "MiniStatuslineFilename",
			strings = {
				filename,
			},
		},

		"%=",

		{
			hl = "MiniStatuslineFileinfo",
			strings = {
				fileinfo,
			},
		},

		{
			hl = mode_hl,
			strings = {
				search,
				location,
			},
		},
	})
end

statusline.setup({
	use_icons = true,

	content = {
		active = active,
	},

	set_vim_settings = false,
})
