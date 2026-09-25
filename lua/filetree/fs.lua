local M = {}
local uv = vim.uv or vim.loop

function M.scandir(path)
	local handle = uv.fs_scandir(path)
	if not handle then
		return {}
	end

	local entries = {}
	while true do
		local name, typ = uv.fs_scandir_next(handle)
		if not name then
			break
		end

		-- Resolve symlinks / unknown types with a real stat call.
		if typ == "link" or not typ then
			local stat = uv.fs_stat(path .. "/" .. name)
			typ = (stat and stat.type) or "file"
		end

		entries[#entries + 1] = { name = name, type = typ }
	end

	table.sort(entries, function(a, b)
		local ad, bd = a.type == "directory", b.type == "directory"
		if ad ~= bd then
			return ad
		end
		return a.name:lower() < b.name:lower()
	end)

	return entries
end

function M.is_dir(path)
	local stat = uv.fs_stat(path)
	return stat ~= nil and stat.type == "directory"
end

function M.exists(path)
	return uv.fs_stat(path) ~= nil
end

function M.mkdir(path)
	return vim.fn.mkdir(path, "p") == 1
end

function M.touch(path)
	local fd = uv.fs_open(path, "w", 420) -- 0644
	if not fd then
		return false
	end
	uv.fs_close(fd)
	return true
end

function M.delete(path)
	if M.is_dir(path) then
		return vim.fn.delete(path, "rf") == 0
	end
	return vim.fn.delete(path) == 0
end

function M.rename(src, dst)
	return uv.fs_rename(src, dst) ~= nil
end

function M.copy(src, dst)
	if M.is_dir(src) then
		vim.fn.system({ "cp", "-r", src, dst })
		return vim.v.shell_error == 0
	end
	return uv.fs_copyfile(src, dst) == true
end

return M
