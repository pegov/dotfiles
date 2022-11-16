set mouse=a
set tabstop=2
set softtabstop=2
set shiftwidth=2
set smarttab
set expandtab
set smartindent

set nu rnu
set nohlsearch
set hidden
set noerrorbells
set nowrap

set ignorecase
set incsearch

set scrolloff=8

set completeopt=menuone,noinsert,noselect
set signcolumn=yes
set syntax=on
set updatetime=250
set linebreak
set cmdheight=1

set shortmess+=c

set laststatus=3

set winbar=%f

set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz

filetype plugin indent on

let g:pyindent_open_paren=shiftwidth()
let g:pyindent_continue=shiftwidth()

call plug#begin()
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'nvim-treesitter/playground'
Plug 'yioneko/nvim-yati'

Plug 'windwp/nvim-autopairs'

Plug 'kassio/neoterm'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'vim-airline/vim-airline'

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Plug 'b3nj5m1n/kommentary'
Plug 'numToStr/Comment.nvim'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'L3MON4D3/LuaSnip'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'

Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'preservim/tagbar'

Plug 'simrat39/rust-tools.nvim'
Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }

Plug 'psf/black'

Plug 'rhysd/vim-clang-format'

Plug 'lukas-reineke/indent-blankline.nvim'
call plug#end()

set termguicolors
let &t_8f = "\e[38;2;%lu;%lu;%lum"
let &t_8b = "\e[48;2;%lu;%lu;%lum"

let g:dracula_colorterm = 0
let g:dracula_italic = 0

colorscheme dracula

highlight Normal ctermbg=None guibg=None
highlight nonText ctermbg=None guibg=None

let mapleader = ' '

nnoremap <leader>l ^

nmap <expr> n (v:count > 0 ? "nzz" : "n")
nnoremap <expr> N (v:count > 0 ? "Nzz" : "N")

" move lines in visual mode
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" undo break points
inoremap , ,<C-g>u
inoremap . .<C-g>u
inoremap ! !<C-g>u
inoremap ? ?<C-g>u
inoremap [ [<C-g>u
inoremap ( (<C-g>u
inoremap { {<C-g>u

" jumps
nnoremap <expr> k (v:count > 5 ? "m'" . v:count : "") . 'k'
nnoremap <expr> j (v:count > 5 ? "m'" . v:count : "") . 'j'

" center after scroll
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" yank, delete, paste
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>p "_dP
vnoremap <leader>p "_dP

" tpope/vim-fugitive
nnoremap <leader>gg :G<CR>

nnoremap <leader><Tab> :tabnext<CR>
nnoremap <leader><S-Tab> :tabprev<CR>

nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

nmap <F8> :TagbarToggle<CR>
nmap <leader>tg :TagbarToggle<CR>
let g:tagbar_sort = 0

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

augroup SAVE
    autocmd!
    autocmd BufWritePre * :call TrimWhitespace()
augroup END

augroup fmt
  autocmd!
  autocmd BufWritePre *.py execute ':Black target_version=py310'
  autocmd BufWritePre *.rs lua vim.lsp.buf.format(nil, 200)
augroup END

autocmd FileType c,cpp,objc nnoremap <leader>cf :ClangFormat<CR>
autocmd FileType c,cpp,objc nnoremap <leader>cF :ClangFormatAutoToggle<CR>

" kassio/neoterm
let g:neoterm_default_mod = 'botright'
let g:neoterm_autoinsert = 1
nnoremap <A-`> :Ttoggle<CR>
inoremap <A-`> <Esc>:Ttoggle<CR>
tnoremap <A-`> <c-\><c-n>:Ttoggle<CR>
nnoremap <leader>tc :Tclose!<CR>

" preservim/nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
noremap <C-n> :NERDTreeToggle<CR>

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'*',
                \ 'Staged'    :'+',
                \ 'Untracked' :'!',
                \ 'Renamed'   :'>',
                \ 'Unmerged'  :'=',
                \ 'Deleted'   :'x',
                \ 'Dirty'     :'X',
                \ 'Ignored'   :'@',
                \ 'Clean'     :'v',
                \ 'Unknown'   :'?',
                \ }

nnoremap <leader>fb <cmd>Telescope file_browser<CR>
nnoremap <leader>fc <cmd>Telescope file_browser path=%:p:h<CR>
nnoremap <leader>fr <cmd>Telescope oldfiles<CR>
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fj <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

lua << EOF

vim.cmd [[highlight IndentBlanklineIndent1 guifg=#525252 gui=nocombine]]

require("indent_blankline").setup {
    space_char_blankline = " ",
    char_highlight_list = {
        "IndentBlanklineIndent1",
    },
}

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
      hijack_netrw = true,
      mappings = {

      }
    }
  }
}

require("telescope").load_extension("file_browser")

require('Comment').setup()

require('nvim-treesitter.configs').setup{
  autotag = {
    enable = true,
  },
  yati = { enable = true},
  ensure_installed = {'python', 'lua', 'typescript', 'vim', 'bash', 'dockerfile', 'c', 'tsx', 'javascript', 'yaml'},
  highlight = {
    enable = true,
    disable = { "rust" },
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,
    disable = {},
  },
  playground = {
      enable = true,
      disable = {},
      updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
      persist_queries = false, -- Whether the query persists across vim sessions
      keybindings = {
        toggle_query_editor = 'o',
        toggle_hl_groups = 'i',
        toggle_injected_languages = 't',
        toggle_anonymous_nodes = 'a',
        toggle_language_display = 'I',
        focus_language = 'f',
        unfocus_language = 'F',
        update = 'R',
        goto_node = '<cr>',
        show_help = '?',
    },
  }
}

require('treesitter-context').setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        -- For all filetypes
        -- Note that setting an entry here replaces all other patterns for this entry.
        -- By setting the 'default' entry below, you can control which nodes you want to
        -- appear in the context window.
        default = {
            'class',
            'function',
            'method',
            -- 'for', -- These won't appear in the context
            -- 'while',
            -- 'if',
            -- 'switch',
            -- 'case',
        },
        -- Example for a specific filetype.
        -- If a pattern is missing, *open a PR* so everyone can benefit.
        --   rust = {
        --       'impl_item',
        --   },
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
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
}

require('nvim-autopairs').setup{}

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gh', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>a', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ft', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
end

-- Setup nvim-cmp.
local cmp = require('cmp')

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  mapping = {
    ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
    ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    ['<C-e>'] = cmp.mapping({
      i = cmp.mapping.abort(),
      c = cmp.mapping.close(),
    }),
    -- select = true - select first even if it is not highlighed
    ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

    ['<Tab>'] = cmp.mapping(function(fallback)
    -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
            -- local entry = cmp.get_selected_entry()
            -- if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
            -- else
               --  cmp.confirm()
            -- end
        else
            fallback()
        end
    end, {"i","s","c",}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
    -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
            -- local entry = cmp.get_selected_entry()
            -- if not entry then
            cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            -- else
               --  cmp.confirm()
            -- end
        else
            fallback()
        end
    end, {"i","s","c",}),
  },

  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'vsnip' }, -- For vsnip users.
    { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

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

-- python
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

  -- fallback
  return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
end

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local rust_opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = true,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                },
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
                procMacro = {
                    enable = true
                },
            }
        }
    },
}

require('rust-tools').setup(rust_opts)
require('crates').setup()

local nvim_lsp = require('lspconfig')

nvim_lsp.pyright.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  before_init = function(_, config)
    config.settings.python.pythonPath = get_python_path(config.root_dir)
  end,
}
nvim_lsp.tsserver.setup{}

nvim_lsp.clangd.setup{
  capabilities = capabilities,
  on_attach = on_attach,
}

EOF
