local mini_files = require("mini.files")

mini_files.setup({
	content = {
		filter = function(fs_entry)
			local name = fs_entry.name
			local lower_name = name:lower()

			return name ~= ".git" and lower_name ~= ".ds_store" and lower_name ~= "thumbs.db"
		end,
	},
	windows = {
		preview = true,
		width_focus = 50,
		width_nofocus = 20,
		width_preview = 35,
	},
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniFilesBufferCreate",
	callback = function(args)
		local buf_id = args.data.buf_id

		vim.keymap.set("n", "<CR>", mini_files.go_in, {
			buffer = buf_id,
			desc = "Open entry",
		})
		vim.keymap.set("n", "<BS>", mini_files.go_out, {
			buffer = buf_id,
			desc = "Go to parent directory",
		})
		vim.keymap.set("n", "q", mini_files.close, {
			buffer = buf_id,
			desc = "Close explorer",
		})
	end,
})
