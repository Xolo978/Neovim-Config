if vim.loader then
	vim.loader.enable()
end

if vim.env.PROF then
	local snacks_path = vim.fn.stdpath("data") .. "/site/pack/core/opt/snacks.nvim"

	if vim.fn.isdirectory(snacks_path) == 1 then
		vim.opt.rtp:prepend(snacks_path)
		vim.cmd.packadd("snacks.nvim")

		require("snacks.profiler").startup({
			startup = {
				event = "VimEnter",
				after = true,
				pick = true,
			},
		})
	else
		vim.notify("snacks.nvim was not found at " .. snacks_path, vim.log.levels.ERROR)
	end
end

require("plugins")
require("config")
require("lsp")
