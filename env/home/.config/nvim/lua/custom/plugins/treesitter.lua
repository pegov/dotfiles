return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	commit = "3b308861a8d7d7bfbe9be51d52e54dcfd9fe3d38",
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
