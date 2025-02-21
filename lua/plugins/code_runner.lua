return {
  "CRAG666/code_runner.nvim",
  config = function()
    require("code_runner").setup({
      filetype = {
        c = "clang",
        cpp = "clang++",
        javascript = "node",
        python = "python3",
        typescript = "bun run",
        rust = { "cd $dir &&", "rustc $fileName &&", "$dir/$fileNameWithoutExt" },
      },
      term = {
        mode = "term",
        position = "bot",
        size = 10,
      },
    })
  end,
  keys = function()
    return {
      { "<leader>rr", "<cmd>RunCode<cr>", desc = "Run Code" },
      { "<leader>rf", "<cmd>RunFile<cr>", desc = "Run File" },
      { "<leader>rp", "<cmd>RunProject<cr>", desc = "Run Project" },
    }
  end,
}
