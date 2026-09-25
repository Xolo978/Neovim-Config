local M = {}

local cache = { root = nil, status = {}, dirs = {}, running = false }

local function classify(x, y)
	if x == "?" and y == "?" then
		return "?"
	end
	if x == "!" and y == "!" then
		return "!"
	end
	if x == "U" or y == "U" or (x == "A" and y == "A") or (x == "D" and y == "D") then
		return "U"
	end
	if x == "R" or y == "R" then
		return "R"
	end
	if x == "A" or y == "A" then
		return "A"
	end
	if x == "D" or y == "D" then
		return "D"
	end
	if x == "M" or y == "M" then
		return "M"
	end
	return nil
end

local STATUS = {
	M = { icon = "M", hl = "FileTreeGitModified" },
	A = { icon = "A", hl = "FileTreeGitAdded" },
	D = { icon = "D", hl = "FileTreeGitDeleted" },
	R = { icon = "R", hl = "FileTreeGitRenamed" },
	U = { icon = "U", hl = "FileTreeGitConflict" },
	["?"] = { icon = "U", hl = "FileTreeGitUntracked" },
	["!"] = { icon = "I", hl = "FileTreeGitIgnored" },
}

local function define_highlights()
	local links = {
		FileTreeGitModified = "DiagnosticWarn",
		FileTreeGitAdded = "DiagnosticOk",
		FileTreeGitDeleted = "DiagnosticError",
		FileTreeGitRenamed = "DiagnosticInfo",
		FileTreeGitConflict = "DiagnosticError",
		FileTreeGitUntracked = "DiagnosticHint",
		FileTreeGitIgnored = "Comment",
	}
	for name, link in pairs(links) do
		if vim.fn.hlID(name) == 0 then
			vim.api.nvim_set_hl(0, name, { link = link, default = true })
		end
	end
end
define_highlights()

local function find_git_root(path)
	local uv = vim.uv or vim.loop
	local dir = path
	for _ = 1, 60 do
		if uv.fs_stat(dir .. "/.git") then
			return dir
		end
		local parent = dir:match("^(.*)/[^/]+$")
		if not parent or parent == dir then
			return nil
		end
		dir = parent
	end
	return nil
end

function M.icon_for(code)
	return STATUS[code]
end

function M.status_for(path)
	return cache.status[path] or cache.dirs[path]
end

function M.refresh(root, on_done)
	local git_root = find_git_root(root)
	if not git_root then
		cache.root, cache.status, cache.dirs = nil, {}, {}
		if on_done then
			on_done()
		end
		return
	end

	if cache.running then
		return
	end
	cache.running = true

	local priority = { U = 6, M = 5, A = 4, D = 4, R = 3, ["?"] = 2, ["!"] = 1 }

	vim.system(
		{ "git", "-C", git_root, "status", "--porcelain=v1", "--ignored" },
		{ text = true },
		vim.schedule_wrap(function(result)
			cache.running = false
			if result.code ~= 0 or not result.stdout then
				return
			end

			local status, dirs = {}, {}
			for line in result.stdout:gmatch("[^\r\n]+") do
				local x, y, rest = line:sub(1, 1), line:sub(2, 2), line:sub(4)
				local file = (rest:match("%-> (.+)$") or rest):gsub('^"(.*)"$', "%1")
				local code = classify(x, y)

				if code and file ~= "" then
					local abs = git_root .. "/" .. file
					status[abs] = code

					local dir = abs:match("^(.*)/[^/]+$")
					local stop_at = git_root:match("^(.*)/[^/]+$")
					while dir and dir ~= stop_at do
						if not dirs[dir] or priority[code] > priority[dirs[dir]] then
							dirs[dir] = code
						end
						local parent = dir:match("^(.*)/[^/]+$")
						if not parent or parent == dir then
							break
						end
						dir = parent
					end
				end
			end

			cache.root, cache.status, cache.dirs = git_root, status, dirs
			if on_done then
				on_done()
			end
		end)
	)
end

return M
