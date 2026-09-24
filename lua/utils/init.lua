local M = {}

function M.is_empty(value)
  return value == nil or value == ""
end

function M.map(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", {
    noremap = true,
    silent = true,
  }, opts or {})

  vim.keymap.set(mode, lhs, rhs, opts)
end

function M.buf_is_valid(bufnr)
  return bufnr and vim.api.nvim_buf_is_valid(bufnr)
end

function M.get_root(bufnr, markers)
  bufnr = bufnr or 0

  local filename = vim.api.nvim_buf_get_name(bufnr)

  if filename == "" then
    return vim.uv.cwd()
  end

  return vim.fs.root(filename, markers) or vim.fs.dirname(filename)
end

return M
