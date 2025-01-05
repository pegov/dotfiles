return {
  'nvim-lualine/lualine.nvim',
	config = function()
		-- Set lualine as statusline
		-- See `:help lualine.txt`
		require('lualine').setup {
				options = {
						icons_enabled = false,
						theme = 'dracula-nvim',
						component_separators = '|',
						section_separators = '',
				},
		}
	end
}