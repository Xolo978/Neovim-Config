local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = " "

opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.breakindent = true
opt.confirm = true
opt.cursorline = true
opt.laststatus = 3
opt.showmode = false
opt.termguicolors = true
opt.virtualedit = "block"
opt.showtabline = 2

opt.number = true
opt.relativenumber = true
opt.numberwidth = 2
opt.signcolumn = "yes"

opt.expandtab = true
opt.shiftwidth = 2
opt.softtabstop = 2
opt.tabstop = 2
opt.smartindent = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.splitbelow = true
opt.splitright = true
opt.equalalways = true

opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.undofile = true
opt.undolevels = 10000
opt.undoreload = 10000

-- Completion
opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
}

opt.pumheight = 10
opt.updatetime = 250
opt.timeoutlen = 500
opt.ttimeoutlen = 10

opt.cmdheight = 1
opt.showcmd = false
opt.ruler = false
opt.shortmess:append({
	I = true,
	c = true,
	F = true,
})

opt.foldenable = true
opt.foldlevel = 99
opt.foldmethod = "indent"

opt.fillchars = {
	eob = " ",
	fold = " ",
	foldopen = "",
	foldclose = "",
	foldsep = " ",
	diff = "╱",
	msgsep = "‾",
}

opt.list = true
opt.listchars = {
	tab = "→ ",
	trail = "·",
	extends = "»",
	precedes = "«",
	nbsp = "␣",
}

opt.completeopt = {
	"menu",
	"menuone",
	"noselect",
	"popup",
}

opt.pumheight = 12

g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1

vim.opt.matchpairs = {
	"(:)",
	"{:}",
	"[:]",
	"<:>",
}

if vim.loader then
	vim.loader.enable()
end
