vim.cmd.colorscheme("habamax")

local highlights = {
	Normal = {
		bg = "NONE",
	},

	NormalFloat = {
		bg = "NONE",
	},

	SignColumn = {
		bg = "NONE",
	},

	FoldColumn = {
		bg = "NONE",
	},

	CursorLine = {
		bg = "#2a2a2a",
	},

	CursorLineNr = {
		fg = "#e5c07b",
		bold = true,
	},

	LineNr = {
		fg = "#5c6370",
	},

	Visual = {
		bg = "#3e4451",
	},

	FloatBorder = {
		fg = "#61afef",
		bg = "NONE",
	},

	WinSeparator = {
		fg = "#3e4451",
		bg = "NONE",
	},

	DiagnosticError = {
		fg = "#e06c75",
	},

	DiagnosticWarn = {
		fg = "#e5c07b",
	},

	DiagnosticInfo = {
		fg = "#61afef",
	},

	DiagnosticHint = {
		fg = "#56b6c2",
	},

	DiagnosticUnnecessary = {
		undercurl = true,
	},

	Search = {
		fg = "#1e2127",
		bg = "#e5c07b",
	},

	IncSearch = {
		fg = "#1e2127",
		bg = "#61afef",
	},

	MatchParen = {
		fg = "#f9e2af",
		bg = "NONE",
		underline = true,
		bold = true,
	},

	Cursor = {
		fg = "#1e1e2e",
		bg = "#f9e2af",
	},

	lCursor = {
		fg = "#1e1e2e",
		bg = "#f9e2af",
	},

	iCursor = {
		fg = "#1e1e2e",
		bg = "#a6e3a1",
	},
	TabLine = {
		fg = "#7f849c",
		bg = "#1e1e2e",
	},

	TabLineSel = {
		fg = "#1e1e2e",
		bg = "#a6e3a1",
		bold = true,
	},

	TabLineFill = {
		fg = "#45475a",
		bg = "#181825",
	},
	MiniStatuslineModeNormal = {
		fg = "#1e2127",
		bg = "#61afef",
		bold = true,
	},

	MiniStatuslineModeInsert = {
		fg = "#1e2127",
		bg = "#98c379",
		bold = true,
	},

	MiniStatuslineModeVisual = {
		fg = "#1e2127",
		bg = "#c678dd",
		bold = true,
	},

	MiniStatuslineModeReplace = {
		fg = "#1e2127",
		bg = "#e06c75",
		bold = true,
	},

	MiniStatuslineModeCommand = {
		fg = "#1e2127",
		bg = "#e5c07b",
		bold = true,
	},

	MiniStatuslineDevinfo = {
		fg = "#abb2bf",
		bg = "#282c34",
	},

	MiniStatuslineFilename = {
		fg = "#d7dae0",
		bg = "#20232a",
		bold = true,
	},

	MiniStatuslineFileinfo = {
		fg = "#abb2bf",
		bg = "#282c34",
	},

	MiniStatuslineInactive = {
		fg = "#5c6370",
		bg = "#1e2127",
	},
}

for group, settings in pairs(highlights) do
	vim.api.nvim_set_hl(0, group, settings)
end
