return {
	"nvim-telescope/telescope.nvim",
	event = "VimEnter",
	commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ -- If encountering errors, see telescope-fzf-native README for installation instructions
			"nvim-telescope/telescope-fzf-native.nvim",

			-- `build` is used to run some command when the plugin is installed/updated.
			-- This is only run then, not every time Neovim starts up.
			build = "make",

			-- `cond` is a condition used to determine whether this plugin should be
			-- installed and loaded.
			cond = function()
				return vim.fn.executable("make") == 1
			end,
		},
	},
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			pickers = {
				buffers = {
					show_all_buffers = true,
					sort_lastused = true,
					theme = "dropdown",
					mappings = {
						i = {
							["<c-d>"] = actions.delete_buffer,
						},
						n = {
							["<c-d>"] = actions.delete_buffer,
						},
					},
				},
			},
			extensions = {
				file_browser = {
					hijack_netrw = false,
				},
				fzf = {},
			},
		})

		-- Enable telescope fzf native, if installed
		pcall(require("telescope").load_extension, "fzf")

		-- See `:help telescope.builtin`
		vim.keymap.set("n", "<leader>/", function()
			-- You can pass additional configuration to telescope to change theme, layout, etc.
			require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "[/] Fuzzily search in current buffer]" })

		vim.keymap.set("n", "<leader>ff", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
		vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
		vim.keymap.set(
			"n",
			"<leader>fw",
			require("telescope.builtin").grep_string,
			{ desc = "[S]earch current [W]ord" }
		)
		vim.keymap.set("n", "<leader>fg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
		vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
		vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
		vim.keymap.set("n", "<leader>fj", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
		vim.keymap.set(
			"n",
			"<leader>f.",
			require("telescope.builtin").oldfiles,
			{ desc = "[.] Find recently opened files" }
		)
	end,
}
