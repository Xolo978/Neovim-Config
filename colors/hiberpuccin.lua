vim.g.colors_name = "hiberpuccin"
vim.o.termguicolors = true
vim.o.background = "dark"
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
	vim.cmd("syntax reset")
end

local p = {
	crust = "#14141d",
	mantle = "#191925",
	base = "#1e1e2b",
	surface0 = "#2a2a3c",
	surface1 = "#34344a",
	surface2 = "#3e3e58",
	overlay0 = "#585873",
	overlay1 = "#6f6f8c",
	overlay2 = "#8787a3",

	-- text
	subtext0 = "#a3a3bd",
	subtext1 = "#bcbcd6",
	text = "#d9d9f0",

	rosewater = "#f2cdcd",
	flamingo = "#f0a8a8",
	pink = "#ff8fd6",
	red = "#ff6b6b",
	maroon = "#e88080",
	peach = "#ffab70",
	yellow = "#ffd479",
	green = "#a6e22e",
	teal = "#63e6d4",
	sky = "#7fd9ff",
	sapphire = "#56c2ff",
	blue = "#5f9bff",
	lavender = "#b39dff",
	mauve = "#c792ea",
}

local function hl(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

hl("Normal", { fg = p.text, bg = p.base })
hl("NormalNC", { fg = p.text, bg = p.base })
hl("NormalFloat", { fg = p.text, bg = p.mantle })
hl("FloatBorder", { fg = p.blue, bg = p.mantle })
hl("FloatTitle", { fg = p.pink, bg = p.mantle, bold = true })
hl("Cursor", { fg = p.base, bg = p.text })
hl("CursorLine", { bg = p.surface0 })
hl("CursorLineNr", { fg = p.yellow, bg = p.surface0, bold = true })
hl("LineNr", { fg = p.overlay1 })
hl("SignColumn", { bg = p.base })
hl("FoldColumn", { fg = p.overlay1 })
hl("Folded", { fg = p.subtext0, bg = p.surface0 })
hl("ColorColumn", { bg = p.surface0 })
hl("WinSeparator", { fg = p.surface1 })
hl("VertSplit", { fg = p.surface1 })
hl("Visual", { bg = p.surface1 })
hl("VisualNOS", { bg = p.surface1 })
hl("Search", { fg = p.base, bg = p.yellow, bold = true })
hl("IncSearch", { fg = p.base, bg = p.peach, bold = true })
hl("CurSearch", { fg = p.base, bg = p.peach, bold = true })
hl("Pmenu", { fg = p.text, bg = p.mantle })
hl("MatchParen", { fg = p.peach, bold = true, underline = true })
hl("PmenuSel", { fg = p.base, bg = p.blue, bold = true })
hl("PmenuSbar", { bg = p.surface0 })
hl("PmenuThumb", { bg = p.overlay0 })
hl("WildMenu", { fg = p.base, bg = p.blue })
hl("StatusLine", { fg = p.text, bg = p.mantle })
hl("StatusLineNC", { fg = p.overlay1, bg = p.mantle })
hl("TabLine", { fg = p.overlay1, bg = p.mantle })
hl("TabLineSel", { fg = p.base, bg = p.lavender, bold = true })
hl("TabLineFill", { bg = p.crust })
hl("Title", { fg = p.pink, bold = true })
hl("Directory", { fg = p.blue, bold = true })
hl("ErrorMsg", { fg = p.red, bold = true })
hl("WarningMsg", { fg = p.yellow, bold = true })
hl("ModeMsg", { fg = p.text, bold = true })
hl("MoreMsg", { fg = p.green })
hl("Question", { fg = p.green })
hl("NonText", { fg = p.overlay0 })
hl("Whitespace", { fg = p.surface1 })
hl("SpecialKey", { fg = p.overlay0 })
hl("EndOfBuffer", { fg = p.base })
hl("Conceal", { fg = p.overlay1 })

hl("DiffAdd", { bg = "#26362a" })
hl("DiffChange", { bg = "#33302a" })
hl("DiffDelete", { bg = "#3a2626" })
hl("DiffText", { bg = "#3f4a3a" })

hl("SpellBad", { sp = p.red, undercurl = true })
hl("SpellCap", { sp = p.yellow, undercurl = true })
hl("SpellLocal", { sp = p.teal, undercurl = true })
hl("SpellRare", { sp = p.mauve, undercurl = true })

hl("Comment", { fg = p.overlay2, italic = false })
hl("String", { fg = p.green })
hl("Character", { fg = p.green })
hl("Number", { fg = p.peach })
hl("Float", { fg = p.peach })
hl("Boolean", { fg = p.peach, bold = true })
hl("Constant", { fg = p.peach })
hl("Identifier", { fg = p.text })
hl("Function", { fg = p.sky, bold = true })
hl("Statement", { fg = p.mauve, bold = true })
hl("Conditional", { fg = p.mauve, bold = true })
hl("Repeat", { fg = p.mauve, bold = true })
hl("Label", { fg = p.mauve })
hl("Operator", { fg = p.teal })
hl("Keyword", { fg = p.mauve, bold = true })
hl("Exception", { fg = p.pink, bold = true })
hl("PreProc", { fg = p.pink, bold = true })
hl("Include", { fg = p.pink, bold = true })
hl("Define", { fg = p.pink })
hl("Macro", { fg = p.pink })
hl("Type", { fg = p.yellow, bold = true })
hl("StorageClass", { fg = p.yellow })
hl("Structure", { fg = p.yellow })
hl("Typedef", { fg = p.yellow })
hl("Special", { fg = p.teal })
hl("SpecialChar", { fg = p.peach })
hl("Delimiter", { fg = p.subtext1 })
hl("Underlined", { fg = p.blue, underline = true })
hl("Ignore", { fg = p.overlay0 })
hl("Todo", { fg = p.base, bg = p.yellow, bold = true })

hl("@variable", { fg = p.text })
hl("@variable.builtin", { fg = p.peach, italic = false })
hl("@variable.parameter", { fg = p.flamingo })
hl("@variable.member", { fg = p.lavender })
hl("@constant", { fg = p.peach })
hl("@constant.builtin", { fg = p.peach, bold = true })
hl("@constant.macro", { fg = p.pink })
hl("@module", { fg = p.yellow })
hl("@label", { fg = p.mauve })
hl("@string", { fg = p.green })
hl("@string.escape", { fg = p.peach, bold = true })
hl("@string.special", { fg = p.teal })
hl("@character", { fg = p.green })
hl("@character.special", { fg = p.peach })
hl("@boolean", { fg = p.peach, bold = true })
hl("@number", { fg = p.peach })
hl("@float", { fg = p.peach })
hl("@function", { fg = p.sky, bold = true })
hl("@function.builtin", { fg = p.sky, bold = true })
hl("@function.call", { fg = p.sapphire })
hl("@function.macro", { fg = p.pink })
hl("@method", { fg = p.sky, bold = true })
hl("@method.call", { fg = p.sapphire })
hl("@constructor", { fg = p.yellow, bold = true })
hl("@parameter", { fg = p.flamingo })
hl("@keyword", { fg = p.mauve, bold = true })
hl("@keyword.function", { fg = p.mauve, bold = true })
hl("@keyword.operator", { fg = p.mauve })
hl("@keyword.return", { fg = p.pink, bold = true })
hl("@keyword.import", { fg = p.pink, bold = true })
hl("@keyword.conditional", { fg = p.mauve, bold = true })
hl("@keyword.repeat", { fg = p.mauve, bold = true })
hl("@keyword.exception", { fg = p.pink, bold = true })
hl("@conditional", { fg = p.mauve, bold = true })
hl("@repeat", { fg = p.mauve, bold = true })
hl("@exception", { fg = p.pink, bold = true })
hl("@operator", { fg = p.teal })
hl("@punctuation.delimiter", { fg = p.subtext1 })
hl("@punctuation.bracket", { fg = p.overlay2 })
hl("@punctuation.special", { fg = p.teal })
hl("@comment", { fg = p.overlay2, italic = false })
hl("@comment.documentation", { fg = p.overlay2, italic = false })
hl("@type", { fg = p.yellow, bold = true })
hl("@type.builtin", { fg = p.yellow, bold = true })
hl("@type.definition", { fg = p.yellow, bold = true })
hl("@attribute", { fg = p.teal })
hl("@property", { fg = p.lavender })
hl("@field", { fg = p.lavender })
hl("@namespace", { fg = p.yellow })
hl("@tag", { fg = p.mauve })
hl("@tag.attribute", { fg = p.flamingo })
hl("@tag.delimiter", { fg = p.overlay2 })
hl("@markup.heading", { fg = p.pink, bold = true })
hl("@markup.strong", { bold = true })
hl("@markup.italic", { italic = false })
hl("@markup.strikethrough", { strikethrough = true })
hl("@markup.underline", { underline = true })
hl("@markup.link", { fg = p.sky, underline = true })
hl("@markup.link.url", { fg = p.sky, underline = true })
hl("@markup.raw", { fg = p.green })
hl("@markup.list", { fg = p.teal })
hl("@diff.plus", { fg = p.green })
hl("@diff.minus", { fg = p.red })
hl("@diff.delta", { fg = p.yellow })

hl("@lsp.type.class", { link = "@type" })
hl("@lsp.type.decorator", { link = "@attribute" })
hl("@lsp.type.enum", { link = "@type" })
hl("@lsp.type.enumMember", { link = "@constant" })
hl("@lsp.type.function", { link = "@function" })
hl("@lsp.type.interface", { link = "@type" })
hl("@lsp.type.macro", { link = "@function.macro" })
hl("@lsp.type.method", { link = "@method" })
hl("@lsp.type.namespace", { link = "@namespace" })
hl("@lsp.type.parameter", { link = "@parameter" })
hl("@lsp.type.property", { link = "@property" })
hl("@lsp.type.struct", { link = "@type" })
hl("@lsp.type.type", { link = "@type" })
hl("@lsp.type.variable", { link = "@variable" })
hl("@lsp.typemod.function.defaultLibrary", { link = "@function.builtin" })
hl("@lsp.typemod.variable.defaultLibrary", { link = "@variable.builtin" })

hl("DiagnosticError", { fg = p.red })
hl("DiagnosticWarn", { fg = p.yellow })
hl("DiagnosticInfo", { fg = p.blue })
hl("DiagnosticHint", { fg = p.teal })
hl("DiagnosticOk", { fg = p.green })
hl("DiagnosticUnderlineError", { sp = p.red, undercurl = true })
hl("DiagnosticUnderlineWarn", { sp = p.yellow, undercurl = true })
hl("DiagnosticUnderlineInfo", { sp = p.blue, undercurl = true })
hl("DiagnosticUnderlineHint", { sp = p.teal, undercurl = true })
hl("DiagnosticVirtualTextError", { fg = p.red, bg = p.mantle })
hl("DiagnosticVirtualTextWarn", { fg = p.yellow, bg = p.mantle })
hl("DiagnosticVirtualTextInfo", { fg = p.blue, bg = p.mantle })
hl("DiagnosticVirtualTextHint", { fg = p.teal, bg = p.mantle })
hl("LspReferenceText", { bg = p.surface0 })
hl("LspReferenceRead", { bg = p.surface0 })
hl("LspReferenceWrite", { bg = p.surface1 })
hl("LspInlayHint", { fg = p.overlay1, bg = p.surface0 })
hl("LspCodeLens", { fg = p.overlay1 })

hl("GitSignsAdd", { fg = p.green })
hl("GitSignsChange", { fg = p.yellow })
hl("GitSignsDelete", { fg = p.red })

hl("BlinkCmpMenu", { fg = p.text, bg = p.mantle })
hl("BlinkCmpMenuBorder", { fg = p.blue, bg = p.mantle })
hl("BlinkCmpDoc", { fg = p.text, bg = p.mantle })
hl("BlinkCmpDocBorder", { fg = p.blue, bg = p.mantle })
hl("BlinkCmpLabelMatch", { fg = p.teal, bold = true })
hl("BlinkCmpKind", { fg = p.mauve })

hl("WhichKey", { fg = p.pink, bold = true })
hl("WhichKeyGroup", { fg = p.blue })
hl("WhichKeyDesc", { fg = p.text })
hl("WhichKeySeparator", { fg = p.overlay1 })
hl("WhichKeyFloat", { bg = p.mantle })

hl("FlashBackdrop", { fg = p.overlay0 })
hl("FlashMatch", { fg = p.base, bg = p.teal, bold = true })
hl("FlashCurrent", { fg = p.base, bg = p.yellow, bold = true })
hl("FlashLabel", { fg = p.base, bg = p.pink, bold = true })

vim.g.terminal_color_0 = p.crust
vim.g.terminal_color_1 = p.red
vim.g.terminal_color_2 = p.green
vim.g.terminal_color_3 = p.yellow
vim.g.terminal_color_4 = p.blue
vim.g.terminal_color_5 = p.pink
vim.g.terminal_color_6 = p.teal
vim.g.terminal_color_7 = p.subtext1
vim.g.terminal_color_8 = p.overlay0
vim.g.terminal_color_9 = p.red
vim.g.terminal_color_10 = p.green
vim.g.terminal_color_11 = p.yellow
vim.g.terminal_color_12 = p.blue
vim.g.terminal_color_13 = p.pink
vim.g.terminal_color_14 = p.teal
vim.g.terminal_color_15 = p.text
