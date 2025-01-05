vim.opt.hidden = true
vim.opt.errorbells = false
vim.opt.wrap = false

vim.opt.number = true
vim.opt.relativenumber = false

vim.opt.mouse = "a"

vim.opt.breakindent = true
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
-- vim.opt.list = true
-- vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

-- Show which line your cursor is on
-- vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.completeopt = "menuone,noinsert,noselect"
vim.opt.syntax = "on"

vim.opt.cmdheight = 1

vim.o.shortmess = vim.o.shortmess .. "c"

vim.opt.laststatus = 3

vim.opt.winbar = "%f"

vim.opt.langmap =
	"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.opt.termguicolors = true

vim.o.linebreak = true
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

vim.cmd([[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup SAVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]])

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)
