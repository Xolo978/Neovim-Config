local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = {
      "stylua",
    },

    c = {
      "clang_format",
    },

    cpp = {
      "clang_format",
    },

    python = {
      "ruff_format",
    },

    rust = {
      "rustfmt",
    },

    sh = {
      "shfmt",
    },

    bash = {
      "shfmt",
    },

    json = {
      "prettier",
    },

    javascript = {
      "prettier",
    },

    typescript = {
      "prettier",
    },

    markdown = {
      "prettier",
    },
  },

  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    return {
      timeout_ms = 1000,
      lsp_format = "fallback",
    }
  end,

  default_format_opts = {
    lsp_format = "fallback",
  },

  notify_on_error = true,
  notify_no_formatters = true,
})

vim.api.nvim_create_user_command("Format", function()
  conform.format({
    async = true,
    lsp_format = "fallback",
  })
end, {
  desc = "Format current buffer",
})

vim.api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    vim.b.disable_autoformat = true
    vim.notify("Format-on-save disabled for this buffer")
  else
    vim.g.disable_autoformat = true
    vim.notify("Format-on-save disabled globally")
  end
end, {
  bang = true,
  desc = "Disable format-on-save",
})

vim.api.nvim_create_user_command("FormatEnable", function()
  vim.g.disable_autoformat = false
  vim.b.disable_autoformat = false
  vim.notify("Format-on-save enabled")
end, {
  desc = "Enable format-on-save",
})
