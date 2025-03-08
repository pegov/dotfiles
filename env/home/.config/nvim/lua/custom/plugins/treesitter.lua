return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	tag = "v0.9.3",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"go",
				"lua",
				"python",
				"rust",
				"typescript",
				"tsx",
				"markdown",
				"bash",
				"fish",
				"javascript",
				"sql",
				"json",
			},
			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},
			indent = { enable = true, disable = { "go" } },
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-y>",
					node_incremental = "<C-y>",
				},
			},
		})
	end,
}
