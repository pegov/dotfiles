return {
	{
		"nvim-tree/nvim-tree.lua",
		config = function()
			require("nvim-tree").setup({
				filters = {
					dotfiles = false,
				},
			})

			local toggle_and_find = function()
				local ntree = require("nvim-tree.api")
				ntree.tree.toggle({ find_file = true })
			end

			vim.keymap.set("n", "<leader>b", toggle_and_find)
		end,
	},
}
