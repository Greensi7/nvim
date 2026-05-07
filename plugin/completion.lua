-- blink.cmp completion configuration
require("blink.cmp").setup({
	keymap = {
		preset = "none",
		["<Up>"] = { "select_prev", "fallback" },
		["<Down>"] = { "select_next", "fallback" },
		["<C-space>"] = { "show", "show_documentation", "hide_documentation" },

		["<Enter>"] = { "select_and_accept", "fallback" },
		["<Tab>"] = { "select_and_accept", "fallback" },
	},
	-- (Default) Only show the documentation popup when manually triggered
	completion = {
		documentation = { auto_show = true },
		menu = {
			draw = {
				columns = {
					{ "label", "label_description", gap = 1 },
					{ "kind_icon", "kind" },
				},
			},
		},
	},

	signature = {
		enabled = true,
		window = {
			treesitter_highlighting = true,
			show_documentation = true,
		},
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})
