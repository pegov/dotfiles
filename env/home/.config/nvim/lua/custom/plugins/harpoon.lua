return {
	"ThePrimeagen/harpoon",
	config = function()
		local harpoon_ui = require("harpoon.ui")
		local harpoon_mark = require("harpoon.mark")
		vim.keymap.set("n", "<leader>h", harpoon_mark.add_file)
		vim.keymap.set("n", "<C-e>", harpoon_ui.toggle_quick_menu)
		vim.keymap.set("n", "<C-h>", harpoon_ui.nav_next)
	end,
}
