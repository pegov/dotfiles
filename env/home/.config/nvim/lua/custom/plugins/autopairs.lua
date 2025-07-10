return {
	"windwp/nvim-autopairs",
	config = function()
		local npairs = require("nvim-autopairs")
		npairs.setup({
			enabled = function(bufnr)
				return false
			end,
		})
	end,
}

