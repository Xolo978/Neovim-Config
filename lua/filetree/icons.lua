local M = {}

local has_mini_icons, mini_icons = pcall(require, "mini.icons")
local has_devicons, devicons = pcall(require, "nvim-web-devicons")

local function char(codepoint)
	return vim.fn.nr2char(codepoint, true)
end

M.folder_closed = char(0xf07b) -- nf-fa-folder
M.folder_open = char(0xf07c) -- nf-fa-folder_open
M.folder_empty = char(0xf114) -- nf-fa-folder_o
M.folder_empty_open = char(0xf115) -- nf-fa-folder_open_o
M.default_file = char(0xf15b) -- nf-fa-file

function M.get_file_icon(name)
	if has_mini_icons then
		local icon, hl = mini_icons.get("file", name)
		if icon then
			return icon, hl
		end
	end

	if has_devicons then
		local ext = name:match("^.+%.([^.]+)$")
		local icon, hl = devicons.get_icon(name, ext, { default = true })
		if icon then
			return icon, hl
		end
	end

	return M.default_file, "Normal"
end

function M.get_folder_icon(name, is_open, is_empty)
	if has_mini_icons then
		local ok, icon, hl, is_default = pcall(mini_icons.get, "directory", name)
		if ok and icon and not is_default then
			return icon, hl
		end
	end

	if is_empty then
		return is_open and M.folder_empty_open or M.folder_empty, "Directory"
	end
	return is_open and M.folder_open or M.folder_closed, "Directory"
end

return M
