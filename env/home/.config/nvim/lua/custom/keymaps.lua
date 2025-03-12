vim.keymap.set("n", "<leader>l", "^")

vim.keymap.set("n", "<leader>z", "^ze")

vim.keymap.set("n", "n", "v:count > 0 ? 'nzzzv' : 'n'", { expr = true, silent = true })
vim.keymap.set("n", "N", "v:count > 0 ? 'nzzzv' : 'N'", { expr = true, silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("i", ",", ",<C-g>u")
vim.keymap.set("i", ".", ".<C-g>u")
vim.keymap.set("i", "!", "!<C-g>u")
vim.keymap.set("i", "?", "?<C-g>u")
vim.keymap.set("i", "[", "[<C-g>u")
vim.keymap.set("i", "(", "(<C-g>u")
vim.keymap.set("i", "{", "{<C-g>u")

-- vim.keymap.set('i', '<C-;>', '<ESC>la') -- tabout

vim.cmd([[nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k']])
vim.cmd([[nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j']])

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set({ "n", "v" }, "<leader>y", '"+y')
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d')
vim.keymap.set({ "n", "v" }, "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>gg", ":G<CR>")

vim.keymap.set("n", "<leader>tt", ":tabe %<CR>")
vim.keymap.set("n", "L", ":tabnext<CR>")
vim.keymap.set("n", "H", ":tabprev<CR>")

-- vim.keymap.set("n", "<Tab>", ":bnext<CR>")
-- vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

vim.keymap.set("n", "<C-q>", "<nop>")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "ge", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

-- duplicate line and keep cursor on the same column
vim.keymap.set("n", "<C-,>", "mmyyp`mj")
vim.keymap.set("i", "<C-,>", "<ESC>mmyyp`mja")

vim.keymap.set("n", "<C-j>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-k>", "<cmd>cprev<CR>zz")

local toggle_qf = function()
	local qf_exists = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win["quickfix"] == 1 then
			qf_exists = true
		end
	end
	if qf_exists == true then
		vim.cmd("cclose")
		return
	end
	if not vim.tbl_isempty(vim.fn.getqflist()) then
		vim.cmd("copen")
	end
end

vim.keymap.set("n", "<C-q>", toggle_qf)

vim.keymap.set("n", "<leader>j", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lprev<CR>zz")

-- vim.keymap.set("n", "<leader>fg", ":copen 15 | :silent :grep ")
local function grep_current_word()
	local word = vim.fn.expand("<cword>") -- Get the word under the cursor
	if word == "" then
		print("No word under the cursor.")
		return
	end
	word = vim.fn.shellescape(word) -- Escape special characters
	vim.cmd("copen 15 | silent grep " .. word) -- Run the grep command
end
vim.keymap.set("n", "<leader>fl", grep_current_word)

vim.keymap.set("n", "gj", "`J")
