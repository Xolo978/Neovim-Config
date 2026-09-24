return {
  lua_ls = {
    cmd = {
      "lua-language-server",
    },

    filetypes = {
      "lua",
    },

    root_markers = {
      ".luarc.json",
      ".luarc.jsonc",
      ".git",
    },

    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },

        diagnostics = {
          globals = {
            "vim",
          },
        },

        workspace = {
          checkThirdParty = false,
        },

        telemetry = {
          enable = false,
        },

        format = {
          enable = false,
        },
      },
    },
  },

  basedpyright = {
    cmd = {
      "basedpyright-langserver",
      "--stdio",
    },

    filetypes = {
      "python",
    },

    root_markers = {
      "pyproject.toml",
      "setup.py",
      "setup.cfg",
      "requirements.txt",
      "Pipfile",
      ".git",
    },

    settings = {
      basedpyright = {
        analysis = {
          typeCheckingMode = "basic",
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
        },
      },
    },
  },

  clangd = {
    cmd = {
      "clangd",
    },

    filetypes = {
      "c",
      "cpp",
      "objc",
      "objcpp",
    },

    root_markers = {
      "compile_commands.json",
      "compile_flags.txt",
      ".clangd",
      ".git",
    },
  },

  rust_analyzer = {
    cmd = {
      "rust-analyzer",
    },

    filetypes = {
      "rust",
    },

    root_markers = {
      "Cargo.toml",
      "rust-project.json",
      ".git",
    },

    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },

        check = {
          command = "clippy",
        },
      },
    },
  },

  bashls = {
    cmd = {
      "bash-language-server",
      "start",
    },

    filetypes = {
      "sh",
      "bash",
    },

    root_markers = {
      ".git",
    },
  },

  jsonls = {
    cmd = {
      "vscode-json-language-server",
      "--stdio",
    },

    filetypes = {
      "json",
      "jsonc",
    },

    root_markers = {
      "package.json",
      ".git",
    },
  },

  marksman = {
    cmd = {
      "marksman",
      "server",
    },

    filetypes = {
      "markdown",
      "markdown.mdx",
    },

    root_markers = {
      ".git",
    },
  },
}
