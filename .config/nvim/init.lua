vim.o.hlsearch = false
vim.o.undofile = true
vim.o.hidden = true
vim.o.errorbells = false
vim.o.wrap = false

vim.wo.number = true
vim.wo.relativenumber = false
vim.wo.signcolumn = 'yes'

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.incsearch = true

vim.o.scrolloff = 8

vim.o.completeopt = 'menuone,noinsert,noselect'
vim.o.syntax = 'on'

vim.o.updatetime = 250
vim.o.linebreak = true
vim.o.cmdheight = 1

vim.o.shortmess = vim.o.shortmess .. "c"

vim.o.laststatus = 3

vim.o.winbar = '%f'

vim.o.langmap =
"ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz"

vim.o.termguicolors = true

vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true
vim.o.breakindent = true

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd [[
fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup SAVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END
]]


local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system { 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path }
    vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
    -- Package manager
    use 'wbthomason/packer.nvim'

    use 'nvim-tree/nvim-tree.lua'

    -- use { 'dracula/vim', as = 'dracula' }
    use 'Mofiqul/dracula.nvim'

    -- Git related plugins
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'
    use 'lewis6991/gitsigns.nvim'

    use 'nvim-lualine/lualine.nvim' -- Fancier statusline
    use 'lukas-reineke/indent-blankline.nvim' -- Add indentation guides even on blank lines
    use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
    use 'tpope/vim-sleuth' -- Detect tabstop and shiftwidth automatically

    use 'windwp/nvim-autopairs'

    use({
        "kylechui/nvim-surround",
        tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    })

    use 'kassio/neoterm'

    -- Fuzzy Finder (files, lsp, etc)
    use { 'nvim-telescope/telescope.nvim', branch = '0.1.x', requires = { 'nvim-lua/plenary.nvim' } }
    use { 'nvim-telescope/telescope-file-browser.nvim', requires = { 'nvim-telescope/telescope.nvim' } }
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', cond = vim.fn.executable 'make' == 1 }

    use { -- Highlight, edit, and navigate code
        'nvim-treesitter/nvim-treesitter',
        run = function()
            pcall(require('nvim-treesitter.install').update { with_sync = true })
        end,
    }
    use 'nvim-treesitter/nvim-treesitter-context'

    use { -- LSP Configuration & Plugins
        'neovim/nvim-lspconfig',
        requires = {
            -- Automatically install LSPs to stdpath for neovim
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',

            -- Useful status updates for LSP
            'j-hui/fidget.nvim',

            -- Additional lua configuration, makes nvim stuff amazing
            'folke/neodev.nvim',
        },
    }

    use { -- Autocompletion
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-nvim-lsp',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip'
        },
    }

    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'

    use 'jose-elias-alvarez/null-ls.nvim'

    use 'simrat39/rust-tools.nvim'
    use 'saecki/crates.nvim'

    use "ray-x/lsp_signature.nvim"

    use "abecodes/tabout.nvim"

    use "ThePrimeagen/harpoon"

    if is_bootstrap then
        require('packer').sync()
    end
end)

if is_bootstrap then
    print '=================================='
    print '    Plugins are being installed'
    print '    Wait until Packer completes,'
    print '       then restart nvim'
    print '=================================='
    return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup('Packer', { clear = true })
vim.api.nvim_create_autocmd('BufWritePost', {
    command = 'source <afile> | silent! LspStop | silent! LspStart | PackerCompile',
    group = packer_group,
    pattern = vim.fn.expand '$MYVIMRC',
})

require("nvim-surround").setup({
    -- Configuration here, or leave empty to use defaults
})

-- Dracula(original) theme setup
-- vim.g.dracula_colorterm = 0
-- vim.g.dracula_italic = 0
-- vim.cmd [[colorscheme dracula]]
-- vim.cmd [[highlight Normal ctermbg=None guibg=None]]
-- vim.cmd [[highlight nonText ctermbg=None guibg=None]]

-- Dracula(new lua impl) theme setup
local dracula = require("dracula")
dracula.setup({
    -- customize dracula color palette
    colors = {
        bg = "#282A36",
        fg = "#F8F8F2",
        selection = "#44475A",
        comment = "#6272A4",
        red = "#FF5555",
        orange = "#FFB86C",
        yellow = "#F1FA8C",
        green = "#50fa7b",
        purple = "#BD93F9",
        cyan = "#8BE9FD",
        pink = "#FF79C6",
        bright_red = "#FF6E6E",
        bright_green = "#69FF94",
        bright_yellow = "#FFFFA5",
        bright_blue = "#D6ACFF",
        bright_magenta = "#FF92DF",
        bright_cyan = "#A4FFFF",
        bright_white = "#FFFFFF",
        menu = "#21222C",
        visual = "#3E4452",
        gutter_fg = "#4B5263",
        nontext = "#3B4048",
    },
    -- show the '~' characters after the end of buffers
    show_end_of_buffer = false, -- default false
    -- use transparent background
    transparent_bg = true, -- default false
    -- set custom lualine background color
    lualine_bg_color = "#44475a", -- default nil
    -- set italic comment
    italic_comment = false, -- default false
    -- overrides the default highlights see `:h synIDattr`
    overrides = {
        -- Examples
        -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
        -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
        -- Nothing = {} -- clear highlight of Nothing
    },
})

vim.cmd [[colorscheme dracula]]
-- vim.cmd [[highlight Normal ctermbg=None guibg=None]]
-- vim.cmd [[highlight nonText ctermbg=None guibg=None]]

-- default maps
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.keymap.set('n', '<leader>l', '^')

vim.keymap.set('n', 'n', "v:count > 0 ? 'nzzzv' : 'n'", { expr = true, silent = true })
vim.keymap.set('n', 'N', "v:count > 0 ? 'nzzzv' : 'N'", { expr = true, silent = true })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('i', ',', ',<C-g>u')
vim.keymap.set('i', '.', '.<C-g>u')
vim.keymap.set('i', '!', '!<C-g>u')
vim.keymap.set('i', '?', '?<C-g>u')
vim.keymap.set('i', '[', '[<C-g>u')
vim.keymap.set('i', '(', '(<C-g>u')
vim.keymap.set('i', '{', '{<C-g>u')

vim.cmd [[nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k']]
vim.cmd [[nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j']]

vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

vim.keymap.set({ 'n', 'v' }, '<leader>y', "\"+y")
vim.keymap.set({ 'n', 'v' }, '<leader>d', "\"_d")
vim.keymap.set({ 'n', 'v' }, '<leader>p', "\"_dP")

vim.keymap.set('n', '<leader>gg', ':G<CR>')

vim.keymap.set('n', '<leader><Tab>', ':tabnext<CR>')
vim.keymap.set('n', '<leader><S-Tab>', ':tabprev<CR>')

vim.keymap.set('n', '<Tab>', ':bnext<CR>')
vim.keymap.set('n', '<S-Tab>', ':bprev<CR>')

require('nvim-tree').setup({
    hijack_netrw = false
})

vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')

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

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#525252 gui=nocombine]]
require("indent_blankline").setup {
    char = '┊',
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
    show_trailing_blankline_indent = false,
}

require("nvim-autopairs").setup()

-- Enable Comment.nvim
require('Comment').setup()

-- Gitsigns
require('gitsigns').setup {
    signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
    },
}

-- Neoterm
vim.g.neoterm_default_mod = 'botright'
vim.g.neoterm_autoinsert = 1

vim.keymap.set('n', '<A-`>', ':Ttoggle<CR>')
vim.keymap.set('i', '<A-`>', '<Esc>:Ttoggle<CR>')
vim.keymap.set('t', '<A-`>', "<c-\\><c-n>:Ttoggle<CR>")
vim.keymap.set('n', '<leader>tc', ':Tclose!<CR>')

-- Telescope
local actions = require("telescope.actions")
require("telescope").setup {
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
            }
        }
    },
    extensions = {
        file_browser = {
            hijack_netrw = false
        }
    }
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')
require("telescope").load_extension("file_browser")

require("harpoon").setup()

local harpoon_mark = require("harpoon.mark")
local harpoon_ui = require("harpoon.ui")

vim.keymap.set('n', '<leader>e', harpoon_mark.add_file)
vim.keymap.set('n', '<C-e>', harpoon_ui.toggle_quick_menu)
vim.keymap.set('n', '<C-j>', harpoon_ui.nav_next)

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fj', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
    })
end, { desc = '[/] Fuzzily search in current buffer]' })

vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

vim.keymap.set('n', '<leader>fb', ':Telescope file_browser<CR>')
vim.keymap.set('n', '<leader>fc', ':Telescope file_browser path=%:p:h<CR>')

require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'typescript', 'help', 'tsx' },
    highlight = { enable = true },
    indent = { enable = true, disable = { 'python', 'rust' } },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-k>',
            -- scope_incremental = '<C->',
            node_incremental = '<C-k>',
        }
    }
}

require('tabout').setup({})

require('treesitter-context').setup {
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for',
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
            -- 'interface',
            'struct',
            'enum',
        },
        -- Patterns for specific filetypes
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        tex = {
            'chapter',
            'section',
            'subsection',
            'subsubsection',
        },
        haskell = {
            'adt'
        },
        rust = {
            'impl_item',
        },
        terraform = {
            'block',
            'object_elem',
            'attribute',
        },
        scala = {
            'object_definition',
        },
        vhdl = {
            'process_statement',
            'architecture_body',
            'entity_declaration',
        },
        markdown = {
            'section',
        },
        elixir = {
            'anonymous_function',
            'arguments',
            'block',
            'do_block',
            'list',
            'map',
            'tuple',
            'quoted_content',
        },
        json = {
            'pair',
        },
        typescript = {
            'export_statement',
        },
        yaml = {
            'block_mapping_pair',
        },
    },
    exact_patterns = {
        -- Example for a specific filetype with Lua patterns
        -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
        -- exactly match "impl_item" only)
        -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
}

-- LSP

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', 'ge', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local lsp_formatting = function(bufnr)
    vim.lsp.buf.format({
        filter = function(client)
            return client.name ~= "tsserver" and client.name ~= "pyright" and client.name ~= "clangd"
        end,
        bufnr = bufnr,
    })
end

local on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
                lsp_formatting(bufnr)
            end,
        })
    end
    local nmap = function(keys, func, desc)
        if desc then
            desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end

    -- local dap = require'dap'
    -- local dapui = require'dapui'
    -- f1-12: , f13-24: shift, f25-36: ctrl
    -- nmap('<F9>', dap.toggle_breakpoint, '[D]ap toggle [B]reakpoint')
    -- nmap('<F21>', dap.clear_breakpoints, '[D]ap clear [B]reakpoints')
    -- nmap('<F29>', dap.restart, '[D]ap [R]estart')
    -- nmap('<leader>dR', dap.run_last, '[D]ap [R]un last')
    -- nmap('<F5>', dap.continue, '[D]ap [C]ontinue')
    -- nmap('<F17>', function() dap.close(); dapui.close() end, '[D]ap [C]lose')
    -- nmap('<leader>duc', dapui.close, '[D]ap [C]lose')
    -- nmap('<F10>', dap.step_over, '[D]ap step over')
    -- nmap('<F11>', dap.step_into, '[D]ap step into')
    -- nmap('<F22>', dap.step_out, '[D]ap step out')

    nmap('<leader>r', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>a', vim.lsp.buf.code_action, '[C]ode [A]ction')

    nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gi', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    nmap('gh', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('gk', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
        vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
end

-- python (get virtual env path)
local util = require('lspconfig/util')
local path = util.path

local function get_python_path(workspace)
    -- use activated virtualenv
    if vim.env.VIRTUAL_ENV then
        return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
    end

    -- find poetry
    local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
    if match ~= '' then
        local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
        return path.join(venv, 'bin', 'python')
    end

    -- find venv folder
    -- MISSING

    -- fallback
    return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

local servers = {
    clangd = {},
    pyright = {},
    rust_analyzer = {
        imports = {
            granularity = {
                group = "module",
            },
        },
        checkOnSave = {
            command = "clippy"
        },
        procMacro = {
            enable = true
        },
        inlayHints = {
            locationLinks = false
        },
        completion = {
            callable = {
                snippets = "add_parentheses",
            }
        }
    },
    tsserver = {},
    -- eslint = {},
    html = {},
    cssls = {},
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    }
}

local null_ls = require("null-ls")


null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.code_actions.eslint_d,
        -- null_ls.builtins.formatting.prettierd.with({
        --     disabled_filetypes = { "js", "json", "yaml", "markdown" },
        -- }),
        -- null_ls.builtins.formatting.eslint_d.with({
        --     disabled_filetypes = { "js" },
        -- }),
        null_ls.builtins.formatting.isort,
        null_ls.builtins.formatting.black,
    },
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    lsp_formatting(bufnr)
                end,
            })
        end
    end,
})

mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
    function(server_name)
        if server_name == 'pyright' then
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
                before_init = function(_, config)
                    config.settings.python.pythonPath = get_python_path(config.root_dir)
                end,
            }
        elseif server_name == 'clangd' then
            require('lspconfig')[server_name].setup {
                cmd = {
                    "clangd",
                    "--background-index",
                    "--suggest-missing-includes",
                    "--function-arg-placeholders=false"
                },
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        elseif server_name == 'rust_analyzer' then
            local rt = require('rust-tools')
            local opts = {
                tools = {
                    hover_actions = {
                        auto_focus = true
                    }
                },
                server = {
                    capabilities = capabilities,
                    on_attach = function(v1, bufnr)
                        on_attach(v1, bufnr)
                        local nmap = function(keys, func, desc)
                            if desc then
                                desc = 'LSP: ' .. desc
                            end

                            vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
                        end
                        nmap('<C-space>', rt.hover_actions.hover_actions, 'rust-tools hover')
                    end,
                    settings = {
                        ['rust-analyzer'] = servers[server_name],
                    }
                },
            }
            rt.setup(opts)
        else
            require('lspconfig')[server_name].setup {
                capabilities = capabilities,
                on_attach = on_attach,
                settings = servers[server_name],
            }
        end
    end
}

-- Turn on lsp status information
require('fidget').setup()

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-d>'] = cmp.mapping.scroll_docs( -4),
        ['<C-u>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    }, {
    { name = 'buffer' },
}
}

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
    sources = {
        { name = 'buffer' }
    }
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.formatting_sync()]]

cfg = {
    verbose = false, -- show debug line number
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    -- set to 0 if you DO NOT want any API comments be shown
    -- This setting only take effect in insert mode, it does not affect signature help in normal
    -- mode, 10 by default

    max_height = 12, -- max height of signature floating_window
    max_width = 80, -- max_width of signature floating_window
    noice = false, -- set to true if you using noice to render markdown
    wrap = true, -- allow doc/signature text wrap inside floating_window, useful if your lsp return doc/sig is too long
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_above_cur_line = true, -- try to place the floating above the current line when possible Note:
    -- will set to true when fully tested, set to false will use whichever side has more space
    -- this setting will be helpful if you do not want the PUM and floating win overlap

    floating_window_off_x = 5, -- adjust float windows x position.
    -- can be either a number or function
    floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline() -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then
            return pumheight
        end

        -- window bottom
        if winheight - winline < pumheight then
            return -pumheight
        end
        return 0
    end,
    close_timeout = 2000, -- close floating window after ms when laster parameter is entered
    fix_pos = false, -- set to true, the floating window will not auto-close until finish all parameters
    hint_enable = true, -- virtual hint enable
    hint_prefix = "> ", -- Panda for parameter, NOTE: for the terminal not support emoji, might crash
    hint_scheme = "String",
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
    },
    always_trigger = false, -- sometime show signature on new line or in middle of parameter can be confusing, set it to false for #58
    auto_close_after = nil, -- autoclose signature float win after x sec, disabled if nil.
    extra_trigger_chars = {}, -- Array of extra characters that will trigger signature completion, e.g., {"(", ","}
    zindex = 200, -- by default it will be on top of all floating windows, set to <= 50 send it to bottom
    padding = '', -- character to pad on left and right of signature can be ' ', or '|'  etc
    transparency = nil, -- disabled by default, allow floating win transparent value 1~100
    shadow_blend = 36, -- if you using shadow as border use this set the opacity
    shadow_guibg = 'Black', -- if you using shadow as border use this set the color e.g. 'Green' or '#121315'
    timer_interval = 200, -- default timer check interval set to lower value if you want to reduce latency
    toggle_key = nil, -- toggle signature on and off in insert mode,  e.g. toggle_key = '<M-x>'
    select_signature_key = nil, -- cycle to next signature, e.g. '<M-n>' function overloading
    move_cursor_key = nil, -- imap, use nvim_set_current_win to move cursor between current win and floating
}

require('lsp_signature').setup(cfg)

vim.keymap.set({ 'i', 'n' }, '<C-l>', function()
    require('lsp_signature').toggle_float_win()
end, { silent = true, noremap = true })
