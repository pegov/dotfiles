return {
	"kdheepak/lazygit.nvim",
	lazy = false,
	cmd = {
		"LazyGit",
		"LazyGitConfig",
		"LazyGitCurrentFile",
		"LazyGitFilter",
		"LazyGitFilterCurrentFile",
	},
	-- optional for floating window border decoration
	dependencies = {
		"nvim-lua/plenary.nvim",
		"akinsho/toggleterm.nvim",
	},
	config = function()
		local term = nil

		local function lg_toggle()
			local Terminal = require("toggleterm.terminal").Terminal

			local size = 90
			local direction = "float"

			if not term then
				term = Terminal:new({
					cmd = "lazygit",
					hidden = true,
					on_exit = function()
						term = nil
					end,
				})
				if term then
					term:toggle(size, direction)

					vim.cmd("set ft=lazygit")
					vim.keymap.set("t", "<a-q>", function()
						term:toggle(size, direction)
					end, { buffer = true })
				end
			else
				term:toggle(size, direction)
			end
		end

		vim.api.nvim_create_user_command("LazyGitToggle", lg_toggle, {})
		vim.keymap.set("n", "<leader><leader>l", "<cmd>LazyGitToggle<cr>", {})
	end,
}
