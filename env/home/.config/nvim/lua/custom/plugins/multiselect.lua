return {
	'smoka7/multicursors.nvim',
	dependencies = {
			'nvimtools/hydra.nvim',
	},
	config = function()
		require('multicursors').setup {
            normal_keys = {
                -- to change default lhs of key mapping change the key
                -- [','] = {
                -- assigning nil to method exits from multi cursor mode
                -- assigning false to method removes the binding
                -- method = N.clear_others,
                -- you can pass :map-arguments here
                -- opts = { desc = 'Clear others' },
                -- },
                ['<C-/>'] = {
                    method = function()
                        require('multicursors.utils').call_on_selections(function(selection)
                            vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
                            local line_count = selection.end_row - selection.row + 1
                            vim.cmd('normal ' .. line_count .. 'gcc')
                        end)
                    end,
                    opts = { desc = 'comment selections' },
                },
            },
            hint_config = false
        }
	end
}