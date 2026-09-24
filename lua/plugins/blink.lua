local blink = require("blink.cmp")

blink.setup({
	keymap = {
		preset = "enter",

		-- Manual completion.
		["<C-Space>"] = {
			"show",
			"fallback",
		},

		-- Navigate completion items.
		["<C-n>"] = {
			"select_next",
			"fallback",
		},

		["<C-p>"] = {
			"select_prev",
			"fallback",
		},

		-- Accept the selected item.
		["<CR>"] = {
			"accept",
			"fallback",
		},
	},

	completion = {
		trigger = {
			-- Important: do not open the menu merely because the cursor is
			-- inside or after a normal keyword.
			show_on_keyword = false,

			-- Still allow LSP trigger characters such as '.', ':', and '>'.
			show_on_trigger_character = true,

			-- Prevent completion from appearing when entering insert mode
			-- on an existing trigger character.
			show_on_insert_on_trigger_character = false,

			-- Keep completion from reopening unexpectedly after backspace.
			show_on_backspace = false,
			show_on_backspace_in_keyword = false,
			show_on_backspace_after_accept = false,
			show_on_backspace_after_insert_enter = false,
		},

		menu = {
			auto_show = true,
			border = "rounded",

			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
				},
			},
		},

		documentation = {
			auto_show = true,
			auto_show_delay_ms = 250,
		},

		ghost_text = {
			enabled = false,
		},
	},

	appearance = {
		nerd_font_variant = "mono",
	},

	signature = {
		enabled = true,

		window = {
			border = "rounded",
		},
	},

	sources = {
		default = {
			"lsp",
			"path",
			"snippets",
			"buffer",
		},
	},

	snippets = {
		expand = function(snippet)
			vim.snippet.expand(snippet)
		end,

		active = function(filter)
			return vim.snippet.active(filter)
		end,

		jump = function(direction)
			vim.snippet.jump(direction)
		end,
	},

	fuzzy = {
		implementation = "lua",
	},
})
