local api = vim.api

local augroup = function(name)
  return api.nvim_create_augroup("user_" .. name, {
    clear = true,
  })
end

-- Highlight yanked text briefly.
api.nvim_create_autocmd("TextYankPost", {
  group = augroup("yank_highlight"),
  desc = "Briefly highlight yanked text",
  callback = function()
    vim.hl.hl_op({
      higroup = "IncSearch",
      timeout = 180,
    })
  end,
})

-- Restore the cursor position when reopening a file.
api.nvim_create_autocmd("BufReadPost", {
  group = augroup("restore_cursor"),
  callback = function(event)
    local mark = api.nvim_buf_get_mark(event.buf, '"')
    local line_count = api.nvim_buf_line_count(event.buf)

    if mark[1] > 0 and mark[1] <= line_count then
      pcall(api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Remove trailing whitespace before saving.
api.nvim_create_autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  pattern = "*",
  callback = function()
    local view = vim.fn.winsaveview()

    vim.cmd([[
      silent! keepjumps keeppatterns %s/\s\+$//e
    ]])

    vim.fn.winrestview(view)
  end,
})

-- Create parent directories automatically when saving.
api.nvim_create_autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function(event)
    local file = api.nvim_buf_get_name(event.buf)

    if file == "" then
      return
    end

    local directory = vim.fs.dirname(file)

    if directory and vim.fn.isdirectory(directory) == 0 then
      vim.fn.mkdir(directory, "p")
    end
  end,
})

-- Resize splits when the terminal changes size.
api.nvim_create_autocmd("VimResized", {
  group = augroup("resize_splits"),
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Use relative numbers only in normal file buffers.
api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = augroup("relative_numbers"),
  callback = function()
    if vim.bo.buftype == "" then
      vim.wo.relativenumber = true
    end
  end,
})

api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = augroup("relative_numbers"),
  callback = function()
    vim.wo.relativenumber = false
  end,
})

-- Close temporary windows with q.
api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "help",
    "qf",
    "man",
    "lspinfo",
    "checkhealth",
    "notify",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false

    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      nowait = true,
    })
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  group = vim.api.nvim_create_augroup("user_dashboard", {
    clear = true,
  }),

  callback = function()
    local args = vim.fn.argv()

    if #args == 0 and vim.fn.line2byte("$") == -1 then
      vim.schedule(function()
        vim.cmd("enew")
        vim.cmd("startinsert")
        vim.cmd("stopinsert")
      end)
    end
  end,
})

-- Check whether files changed outside Neovim.
api.nvim_create_autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup("checktime"),
  callback = function()
    vim.cmd("checktime")
  end,
})
