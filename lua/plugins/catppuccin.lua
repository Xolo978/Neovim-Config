local catppuccin = require("catppuccin")

catppuccin.setup({
	flavour = "mocha",

	background = {
		light = "latte",
		dark = "mocha",
	},

	transparent_background = true,

	float = {
		transparent = true,
		solid = false,
	},

	term_colors = true,

	dim_inactive = {
		enabled = false,
	},

	no_italic = true,

	styles = {
		comments = {},
		conditionals = {},
		loops = {},
		functions = { "bold" },
		keywords = { "bold" },
		strings = {},
		variables = {},
		numbers = {},
		booleans = { "bold" },
		properties = {},
		types = { "bold" },
		operators = {},
		miscs = {},
	},

	lsp_styles = {
		virtual_text = {
			errors = {},
			hints = {},
			warnings = {},
			information = {},
			ok = {},
		},

		underlines = {
			errors = { "underline" },
			hints = { "underline" },
			warnings = { "underline" },
			information = { "underline" },
			ok = { "underline" },
		},

		inlay_hints = {
			background = false,
		},
	},

	auto_integrations = false,

	integrations = {
		blink_cmp = {
			style = "bordered",
		},

		gitsigns = true,
		mason = true,
		neotree = true,

		mini = {
			enabled = true,
			indentscope_color = "lavender",
		},

		which_key = true,
	},

	custom_highlights = function(colors)
		return {

			Normal = {
				fg = colors.text,
				bg = colors.base,
			},

			NormalNC = {
				fg = colors.text,
				bg = colors.base,
			},

			NormalFloat = {
				fg = colors.text,
				bg = colors.mantle,
			},

			FloatBorder = {
				fg = colors.blue,
				bg = colors.mantle,
				bold = true,
			},

			FloatTitle = {
				fg = colors.pink,
				bg = colors.mantle,
				bold = true,
			},

			CursorLine = {
				bg = colors.surface0,
			},

			CursorLineNr = {
				fg = colors.yellow,
				bg = colors.surface0,
				bold = true,
			},

			LineNr = {
				fg = colors.overlay1,
				bg = colors.base,
			},

			SignColumn = {
				bg = colors.base,
			},

			FoldColumn = {
				fg = colors.overlay1,
				bg = colors.base,
			},

			WinSeparator = {
				fg = colors.surface1,
				bg = colors.base,
			},

			Visual = {
				bg = colors.surface1,
			},

			MatchParen = {
				fg = colors.base,
				bg = colors.peach,
				bold = true,
				underline = true,
			},

			Comment = {
				fg = colors.overlay2,
				italic = false,
			},

			["@comment"] = {
				fg = colors.overlay2,
				italic = false,
			},

			String = {
				fg = colors.green,
			},

			["@string"] = {
				fg = colors.green,
			},

			["@string.escape"] = {
				fg = colors.peach,
				bold = true,
			},

			Number = {
				fg = colors.peach,
			},

			["@number"] = {
				fg = colors.peach,
			},

			Constant = {
				fg = colors.peach,
			},

			["@constant"] = {
				fg = colors.peach,
			},

			["@constant.builtin"] = {
				fg = colors.peach,
				bold = true,
			},

			Function = {
				fg = colors.sky,
				bold = true,
			},

			["@function"] = {
				fg = colors.sky,
				bold = true,
			},

			["@function.call"] = {
				fg = colors.sapphire,
			},

			["@method"] = {
				fg = colors.sky,
				bold = true,
			},

			["@method.call"] = {
				fg = colors.sapphire,
			},

			Keyword = {
				fg = colors.mauve,
				bold = true,
			},

			Statement = {
				fg = colors.mauve,
				bold = true,
			},

			Conditional = {
				fg = colors.mauve,
				bold = true,
			},

			Repeat = {
				fg = colors.mauve,
				bold = true,
			},

			["@keyword"] = {
				fg = colors.mauve,
				bold = true,
			},

			["@keyword.function"] = {
				fg = colors.mauve,
				bold = true,
			},

			["@keyword.return"] = {
				fg = colors.pink,
				bold = true,
			},

			Type = {
				fg = colors.yellow,
				bold = true,
			},

			["@type"] = {
				fg = colors.yellow,
				bold = true,
			},

			["@type.builtin"] = {
				fg = colors.yellow,
				bold = true,
			},

			["@constructor"] = {
				fg = colors.yellow,
				bold = true,
			},

			Identifier = {
				fg = colors.text,
			},

			["@variable"] = {
				fg = colors.text,
			},

			["@parameter"] = {
				fg = colors.flamingo,
			},

			["@property"] = {
				fg = colors.lavender,
			},

			["@field"] = {
				fg = colors.lavender,
			},

			Operator = {
				fg = colors.teal,
			},

			["@operator"] = {
				fg = colors.teal,
			},

			Delimiter = {
				fg = colors.subtext1,
			},

			["@punctuation.delimiter"] = {
				fg = colors.subtext1,
			},

			["@punctuation.bracket"] = {
				fg = colors.overlay2,
			},

			PreProc = {
				fg = colors.pink,
				bold = true,
			},

			Include = {
				fg = colors.pink,
				bold = true,
			},

			Special = {
				fg = colors.teal,
			},

			NeoTreeNormal = {
				fg = colors.text,
				bg = colors.mantle,
			},

			NeoTreeNormalNC = {
				fg = colors.subtext1,
				bg = colors.mantle,
			},

			NeoTreeEndOfBuffer = {
				fg = colors.mantle,
				bg = colors.mantle,
			},

			NeoTreeWinSeparator = {
				fg = colors.surface1,
				bg = colors.mantle,
			},

			NeoTreeCursorLine = {
				bg = colors.surface0,
			},

			NeoTreeDirectoryIcon = {
				fg = colors.sapphire,
			},

			NeoTreeDirectoryName = {
				fg = colors.blue,
				bold = true,
			},

			NeoTreeRootName = {
				fg = colors.lavender,
				bold = true,
			},

			NeoTreeFileName = {
				fg = colors.text,
			},

			NeoTreeFileNameOpened = {
				fg = colors.teal,
				bold = true,
			},

			NeoTreeGitAdded = {
				fg = colors.green,
			},

			NeoTreeGitModified = {
				fg = colors.yellow,
			},

			NeoTreeGitDeleted = {
				fg = colors.red,
			},

			NeoTreeGitConflict = {
				fg = colors.peach,
				bold = true,
			},

			NeoTreeGitUntracked = {
				fg = colors.teal,
			},

			OilNormal = {
				fg = colors.text,
				bg = colors.mantle,
			},

			OilNormalNC = {
				fg = colors.subtext1,
				bg = colors.mantle,
			},

			OilDir = {
				fg = colors.blue,
				bold = true,
			},

			OilFile = {
				fg = colors.text,
			},

			OilLink = {
				fg = colors.lavender,
			},

			BlinkCmpMenu = {
				fg = colors.text,
				bg = colors.mantle,
			},

			BlinkCmpMenuBorder = {
				fg = colors.blue,
				bg = colors.mantle,
			},

			BlinkCmpDoc = {
				fg = colors.text,
				bg = colors.mantle,
			},

			BlinkCmpDocBorder = {
				fg = colors.blue,
				bg = colors.mantle,
			},

			BlinkCmpLabelMatch = {
				fg = colors.teal,
				bold = true,
			},

			BlinkCmpKind = {
				fg = colors.mauve,
			},

			FlashBackdrop = {
				fg = colors.overlay0,
			},

			FlashMatch = {
				fg = colors.base,
				bg = colors.teal,
				bold = true,
			},

			FlashCurrent = {
				fg = colors.base,
				bg = colors.yellow,
				bold = true,
			},

			FlashLabel = {
				fg = colors.base,
				bg = colors.pink,
				bold = true,
			},

			FlashPrompt = {
				fg = colors.text,
				bg = colors.mantle,
			},

			FlashPromptIcon = {
				fg = colors.peach,
				bg = colors.mantle,
				bold = true,
			},

			MiniTablineCurrent = {
				fg = colors.base,
				bg = colors.lavender,
				bold = true,
			},

			MiniTablineVisible = {
				fg = colors.text,
				bg = colors.surface0,
			},

			MiniTablineHidden = {
				fg = colors.overlay1,
				bg = colors.mantle,
			},

			MiniTablineModifiedCurrent = {
				fg = colors.base,
				bg = colors.yellow,
				bold = true,
			},

			MiniTablineModifiedVisible = {
				fg = colors.yellow,
				bg = colors.surface0,
			},

			MiniTablineModifiedHidden = {
				fg = colors.yellow,
				bg = colors.mantle,
			},

			MiniTablineFill = {
				bg = colors.crust,
			},

			MiniStatuslineModeNormal = {
				fg = colors.base,
				bg = colors.blue,
				bold = true,
			},

			MiniStatuslineModeInsert = {
				fg = colors.base,
				bg = colors.green,
				bold = true,
			},

			MiniStatuslineModeVisual = {
				fg = colors.base,
				bg = colors.mauve,
				bold = true,
			},

			MiniStatuslineModeReplace = {
				fg = colors.base,
				bg = colors.red,
				bold = true,
			},

			MiniStatuslineModeCommand = {
				fg = colors.base,
				bg = colors.peach,
				bold = true,
			},

			MiniStatuslineFilename = {
				fg = colors.text,
				bg = colors.surface0,
				bold = true,
			},

			MiniStatuslineDevinfo = {
				fg = colors.subtext1,
				bg = colors.mantle,
			},

			MiniStatuslineFileinfo = {
				fg = colors.subtext1,
				bg = colors.mantle,
			},

			MiniStatuslineInactive = {
				fg = colors.overlay1,
				bg = colors.crust,
			},
		}
	end,
})

vim.cmd.colorscheme("catppuccin-nvim")
