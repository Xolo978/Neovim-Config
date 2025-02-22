local function select_all_in_insert_mode()
  local pos = vim.fn.getpos(".")
  vim.cmd("normal! <ESC>ggVG")
  vim.fn.setpos(".", pos)
  vim.cmd("startinsert")
end

local map = vim.keymap.set

map({ "n", "v", "i" }, "<C-a>", function()
  if vim.fn.mode() == "i" then
    select_all_in_insert_mode()
  else
    vim.cmd("normal! ggVG")
  end
end, { noremap = true, silent = true, desc = "Select All" })

map({ "n", "v", "i" }, "<C-c>", '"+y', { noremap = true, silent = true, desc = "Copy to Clipboard" })
map({ "n", "v", "i" }, "<C-v>", '"+p', { noremap = true, silent = true, desc = "Paste from Clipboard" })
