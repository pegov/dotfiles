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
		local lg_term = nil
		local ge_term = nil

		local t = require("toggleterm.terminal").Terminal

		local size = 90

		local size_w_f = function()
			return vim.o.columns * 0.95
		end
		local size_h_f = function()
			return vim.o.lines * 0.9
		end

		local direction = "float"

		local function lg_toggle()
			if not lg_term then
				lg_term = t:new({
					cmd = "lazygit",
					hidden = true,
					on_exit = function()
						lg_term = nil
					end,
				})
				if lg_term then
					lg_term:toggle(size(), direction)

					vim.cmd("set ft=lazygit")
					vim.keymap.set("t", "<a-q>", function()
						lg_term:toggle(size(), direction)
					end, { buffer = true })
				end
			else
				lg_term:toggle(size, direction)
			end
		end

		local function ge_term_toggle()
			if not ge_term then
				ge_term = t:new({
					float_opts = {
						width = math.ceil(size_w_f()),
						height = math.ceil(size_h_f()),
					},
					hidden = true,
					on_exit = function()
						ge_term = nil
					end,
				})
				if ge_term then
					ge_term:toggle(size, direction)

					vim.cmd("set ft=general_terminal")
					vim.keymap.set("t", "<F2>", function()
						ge_term:toggle(size, direction)
					end)
				end
			else
				ge_term:toggle(size, direction)
			end
		end

		vim.api.nvim_create_user_command("LazyGitToggle", lg_toggle, {})
		vim.keymap.set("n", "<leader><leader>l", "<cmd>LazyGitToggle<cr>", {})

		vim.api.nvim_create_user_command("GeneralTermToggle", ge_term_toggle, {})
		vim.keymap.set("n", "<F2>", "<cmd>GeneralTermToggle<cr>", {})
	end,
}
