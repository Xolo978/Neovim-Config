local api = vim.api

api.nvim_create_autocmd("LspAttach", {
  group = api.nvim_create_augroup("user_lsp_attach", {
    clear = true,
  }),

  callback = function(event)
    local bufnr = event.buf

    local function map(mode, lhs, rhs, description)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = bufnr,
        silent = true,
        noremap = true,
        desc = description,
      })
    end

    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
    map("n", "gr", vim.lsp.buf.references, "Show references")

    map("n", "K", vim.lsp.buf.hover, "Show documentation")
    map("n", "<C-k>", vim.lsp.buf.signature_help, "Show signature help")

    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action / auto-fix")
    map("n", "<leader>cr", vim.lsp.buf.rename, "Rename symbol")
    map("n", "<leader>ct", vim.lsp.buf.type_definition, "Go to type definition")

    map("n", "<leader>cd", function()
      vim.diagnostic.open_float(nil, {
        border = "rounded",
        focus = true,
        scope = "line",
      })
    end, "Show line diagnostic")

    map("n", "[d", function()
      vim.diagnostic.jump({
        count = -1,
        float = true,
      })
    end, "Previous diagnostic")

    map("n", "]d", function()
      vim.diagnostic.jump({
        count = 1,
        float = true,
      })
    end, "Next diagnostic")

    map({ "n", "v" }, "<leader>lf", "<cmd>Format<cr>", "Format buffer")
  end,
})
