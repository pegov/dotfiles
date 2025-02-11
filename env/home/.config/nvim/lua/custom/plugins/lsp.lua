return {
	-- LSP Plugins
	{
		-- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
		-- used for completion, annotations and signatures of Neovim apis
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				-- Load luvit types when the `vim.uv` word is found
				{ path = "luvit-meta/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true },
	{
		-- Main LSP Configuration
		"neovim/nvim-lspconfig",
		dependencies = {
			-- Automatically install LSPs and related tools to stdpath for Neovim
			{ "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			-- Useful status updates for LSP.
			-- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
			{ "j-hui/fidget.nvim", opts = {} },

			-- Allows extra capabilities provided by nvim-cmp
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
				callback = function(event)
					-- NOTE: Remember that Lua is a real programming language, and as such it is possible
					-- to define small helper and utility functions so you don't have to repeat yourself.
					--
					-- In this case, we create a function that lets us more easily define mappings specific
					-- for LSP related items. It sets the mode, buffer and description for us each time.
					local map = function(keys, func, desc, mode)
						mode = mode or "n"
						vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end

					-- Jump to the definition of the word under your cursor.
					--  This is where a variable was first declared, or where a function is defined, etc.
					--  To jump back, press <C-t>.
					-- map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
					map("gd", vim.lsp.buf.definition, "[G]oto [D]efinition")

					-- Find references for the word under your cursor.
					-- map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
					map("gr", vim.lsp.buf.references, "[G]oto [R]eferences")

					-- Jump to the implementation of the word under your cursor.
					--  Useful when your language has ways of declaring types without an actual implementation.
					-- map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
					map("gi", vim.lsp.buf.implementation, "[G]oto [I]mplementation")

					-- Jump to the type of the word under your cursor.
					--  Useful when you're not sure what type a variable is and you want to see
					--  the definition of its *type*, not where it was *defined*.
					map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

					-- Fuzzy find all the symbols in your current document.
					--  Symbols are things like variables, functions, types, etc.
					map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

					-- Fuzzy find all the symbols in your current workspace.
					--  Similar to document symbols, except searches over your entire project.
					map(
						"<leader>ws",
						require("telescope.builtin").lsp_dynamic_workspace_symbols,
						"[W]orkspace [S]ymbols"
					)

					-- Rename the variable under your cursor.
					--  Most Language Servers support renaming across files, etc.
					map("<leader>r", vim.lsp.buf.rename, "[R]e[n]ame")

					-- Execute a code action, usually your cursor needs to be on top of an error
					-- or a suggestion from your LSP for this to activate.
					map("<leader>a", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

					-- WARN: This is not Goto Definition, this is Goto Declaration.
					--  For example, in C this would take you to the header.
					map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

					map("gh", vim.lsp.buf.hover, "Hover Documentation")
					map("gk", vim.lsp.buf.signature_help, "Signature Documentation")

					-- The following two autocommands are used to highlight references of the
					-- word under your cursor when your cursor rests there for a little while.
					--    See `:help CursorHold` for information about when this is executed
					--
					-- When you move your cursor, the highlights will be cleared (the second autocommand).
					local client = vim.lsp.get_client_by_id(event.data.client_id)
					-- if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
					--   local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
					--   vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
					--     buffer = event.buf,
					--     group = highlight_augroup,
					--     callback = vim.lsp.buf.document_highlight,
					--   })

					--   vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
					--     buffer = event.buf,
					--     group = highlight_augroup,
					--     callback = vim.lsp.buf.clear_references,
					--   })

					--   vim.api.nvim_create_autocmd('LspDetach', {
					--     group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
					--     callback = function(event2)
					--       vim.lsp.buf.clear_references()
					--       vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
					--     end,
					--   })
					-- end

					-- if client.name == "ruff_lsp" then
					--   client.server_capabilities.hoverProvider = false
					-- end
					if client.name == "gopls" then
						map("<leader>th", function()
							local status = vim.lsp.inlay_hint.is_enabled() and "OFF" or "ON"
							vim.api.nvim_notify("Toggling inlay hints " .. status, vim.log.levels.INFO, {})
							vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
						end, "[T]oggle Inlay [H]ints")

						local optionsM = {
							"GoAddTag json",
							"GoAddTag",
							"GoRmTag json",
							"GoRmTag",
							"GoClearTag",
							"GoFillStruct",
							"GoFillSwitch",
						}

						local optionsN = {
							"GoTestFunc",
							"GoTestFile",
						}

						local function callOptionsM()
							vim.ui.select(optionsM, {
								prompt = "Choose go.nvim feature: ",
								format_item = function(item)
									return item
								end,
							}, function(choise)
								if choise then
									if
										choise == "GoAddTag json"
										or choise == "GoRmTag json"
										or choise == "GoClearTag"
										or choise == "GoFillStruct"
										or choise == "GoFillSwitch"
									then
										vim.cmd(choise)
									else
										vim.api.nvim_feedkeys(":" .. choise, "n", true)
									end
								end
							end)
						end

						local function callOptionsN()
							vim.ui.select(optionsN, {
								prompt = "Choose go.nvim feature: ",
								format_item = function(item)
									return item
								end,
							}, function(choise)
								if choise then
									vim.cmd(choise)
								end
							end)
						end

						map("<leader>me", ":GoIfErr<CR>", "if err")
						map("<leader>mm", callOptionsM, "go.nvim m")
						map("<leader>mn", callOptionsN, "go.nvim n")
					else
						if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
							map("<leader>th", function()
								vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
							end, "[T]oggle Inlay [H]ints")
						end
					end

					-- The following code creates a keymap to toggle inlay hints in your
					-- code, if the language server you are using supports them
					--
					-- This may be unwanted, since they displace some of your code
				end,
			})

			local servers = {
				clangd = {
					cmd = { "clangd", "--function-arg-placeholders=0" },
				},
				gopls = {},
				-- pyright = {
				--   settings = {
				--     pyright = {
				--       disableOrganizeImports = true,
				--     },
				--     python = {
				--       analysis = {
				--         ignore = { '*' },
				--       },
				--     },
				--   },
				-- },
				-- pyright = {},
				rust_analyzer = {},
				-- ruff_lsp = {},
				lua_ls = {
					-- cmd = {...},
					-- filetypes = { ...},
					-- capabilities = {},
					settings = {
						Lua = {
							completion = {
								callSnippet = "Replace",
							},
							-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
							-- diagnostics = { disable = { 'missing-fields' } },
						},
					},
				},
			}

			require("mason").setup()

			-- You can add other tools here that you want Mason to install
			-- for you, so that they are available from within Neovim.
			local ensure_installed = vim.tbl_keys(servers or {})
			vim.list_extend(ensure_installed, {
				"stylua", -- Used to format Lua code
			})
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			-- python (get virtual env path)
			-- local util = require('lspconfig/util')
			-- local path = util.path

			-- local function get_python_path(workspace)
			--     -- use activated virtualenv
			--     if vim.env.VIRTUAL_ENV then
			--         return path.join(vim.env.VIRTUAL_ENV, 'bin', 'python')
			--     end

			--     -- find poetry
			--     local match = vim.fn.glob(path.join(workspace, 'poetry.lock'))
			--     if match ~= '' then
			--         local venv = vim.fn.trim(vim.fn.system('poetry env info -p'))
			--         return path.join(venv, 'bin', 'python')
			--     end

			--     -- find venv folder
			--     -- MISSING

			--     -- fallback
			--     return vim.fn.exepath('python3') or vim.fn.exepath('python') or 'python'
			-- end

			require("mason-lspconfig").setup({
				handlers = {
					function(server_name)
						-- if server_name == 'pyright' then
						--   local server = servers[server_name] or {}
						--   server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
						--   server.before_init = function(_, config)
						--     config.settings.python.pythonPath = get_python_path(config.root_dir)
						--   end
						--   require('lspconfig')[server_name].setup(server)
						-- else
						--
						local capabilities = vim.lsp.protocol.make_client_capabilities()
						capabilities =
							vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

						local server = servers[server_name] or {}
						if server_name == "gopls" then
							local get_current_gomod = function()
								local file = io.open("go.mod", "r")
								if file == nil then
									return nil
								end

								local first_line = file:read()
								local mod_name = first_line:gsub("module ", "")
								file:close()
								return mod_name
							end

							function string.starts(String, Start)
								if String == nil or Start == nil then
									return false
								end
								return string.sub(String, 1, string.len(Start)) == Start
							end

							local function read_file_as_list(filename)
								local lines = {}
								local file = io.open(filename, "r")
								if not file then
									error("Could not open file: " .. filename)
								end

								for line in file:lines() do
									table.insert(lines, line)
								end

								file:close()
								return lines
							end

							local get_go_local = function()
								local mod_name = get_current_gomod()
								local private_repos_filename = os.getenv("HOME")
									.. "/.local/share/dmn/nvim-private-go-no-imports-fmt-repos"
								local private_repos = read_file_as_list(private_repos_filename)
								local public_repos = {}

								local myrepos = {}
								for _, str in ipairs(private_repos) do
									table.insert(myrepos, str)
								end
								for _, str in ipairs(public_repos) do
									table.insert(myrepos, str)
								end

								for _, repo in ipairs(myrepos) do
									if string.starts(mod_name, repo) then
										return ""
									end
								end

								return mod_name
							end

							require("go").setup({
								lsp_cfg = false,
								tag_transform = "snakecase",
								tag_options = "json=",
								lsp_inlay_hints = {
									enable = false,
								},
							})

							local range_format = "textDocument/rangeFormatting"
							local formatting = "textDocument/formatting"
							local vfn = vim.fn
							local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
							vim.api.nvim_create_autocmd("BufWritePre", {
								pattern = "*.go",
								callback = function()
									-- require("go.format").gofmt()
									require("go.format").goimports()
								end,
								group = format_sync_grp,
							})
							server = {
								cmd = {
									"gopls",
									"-remote.debug=:0",
								},
								flags = { allow_incremental_sync = true, debounce_text_changes = 500 },
								handlers = {
									[range_format] = function(...)
										vim.lsp.handlers[range_format](...)
										if vfn.getbufinfo("%")[1].changed == 1 then
											vim.cmd("noautocmd write")
										end
									end,
									[formatting] = function(...)
										vim.lsp.handlers[formatting](...)
										if vfn.getbufinfo("%")[1].changed == 1 then
											vim.cmd("noautocmd write")
										end
									end,
								},
								settings = {
									gopls = {
										completeFunctionCalls = true,
										usePlaceholders = false,
										completeUnimported = true,
										staticcheck = true,
										["local"] = get_go_local(),
										analyses = {
											unreachable = true,
											nilness = true,
											unusedparams = true,
											useany = true,
											unusedwrite = true,
											ST1003 = true,
											undeclaredname = true,
											fillreturns = true,
											nonewvars = true,
											fieldalignment = false,
											shadow = true,
										},
										-- codelenses = {
										-- 	test = true,
										-- 	tidy = true,
										-- },
										hints = {
											enabled = false,
											assignVariableTypes = false,
											compositeLiteralFields = false,
											compositeLiteralTypes = false,
											constantValues = false,
											functionTypeParameters = true,
											parameterNames = true,
											rangeVariableTypes = false,
										},
									},
								},
							}
						end

						server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
						require("lspconfig")[server_name].setup(server)
					end,
				},
			})
		end,
	},
}
