local nullLs_format = { "pyright", "tsserver", "sumneko_lua", "cssls", "jsonls", "html" }
local nullLs_diagnostic = { "pyright", "tsserver" }
local no_cursor_hold = { "jsonls", "yamlls" }
Diagnostic = true
CursorHold = true

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

local diagnostic_config = {
	update_in_insert = false,
	virtual_text = true,
	signs = { active = signs },
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
	},
}

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	-- Enable completion triggered by <c-x><c-o>
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	-- Mappings.
	local opts = { noremap = true, silent = true }

	-- See `:help vim.lsp.*` for documentation on any of the below functions
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float({border = 'rounded'})<CR>", opts)
	buf_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev({border = 'rounded'})<CR>", opts)
	buf_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next({border = 'rounded'})<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

	for _, value in ipairs(nullLs_format) do
		if client.name == value then
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_range_formatting = false
		end
	end

	if client.resolved_capabilities.document_formatting then
		vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.formatting_sync()" })
	end

	for _, value in ipairs(nullLs_diagnostic) do
		if client.name == value then
			Diagnostic = false
		end
	end

	for _, value in ipairs(no_cursor_hold) do
		if client.name == value then
			CursorHold = false
		end
	end

	-- if Diagnostic then
	-- 	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
	-- 		vim.lsp.diagnostic.on_publish_diagnostics,
	-- 		diagnostic_config
	-- 	)
	-- else
	-- 	vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
	-- end

	if CursorHold then
		local group = vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
		vim.api.nvim_create_autocmd(
			{ "CursorHold", "CursorHoldI" },
			{ command = "lua vim.lsp.buf.document_highlight()", group = group }
		)
		vim.api.nvim_create_autocmd("CursorMoved", { command = "lua vim.lsp.buf.clear_references()", group = group })
	end
end

-- LSP settings (for overriding per client)
local handlers = {
	["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" }),
	["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" }),
	["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, diagnostic_config),
}

vim.diagnostic.config(diagnostic_config)
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
require("nvim-lsp-installer").setup()
local lspconfig = require("lspconfig")

-- local servers = { 'pyright', 'rust_analyzer', 'tsserver' }
local servers = { "bashls", "pyright" }
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		flags = {
			debounce_text_changes = 150,
		},
	})
end

lspconfig.sumneko_lua.setup({
	capabilities = capabilities,
	on_attach = on_attach,
	handlers = handlers,
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = { "vim", "use" },
			},
		},
	},
})

-- flutter
require("flutter-tools").setup({
	ui = {
		-- the border type to use for all floating windows, the same options/formats
		-- used for ":h nvim_open_win" e.g. "single" | "shadow" | {<table-of-eight-chars>}
		border = "rounded",
	},
	decorations = {
		statusline = {
			-- set to true to be able use the 'flutter_tools_decorations.app_version' in your statusline
			-- this will show the current version of the flutter app from the pubspec.yaml file
			app_version = false,
			-- set to true to be able use the 'flutter_tools_decorations.device' in your statusline
			-- this will show the currently running device if an application was started with a specific
			-- device
			device = false,
		},
	},
	debugger = { -- integrate with nvim dap + install dart code debugger
		enabled = true,
		run_via_dap = false, -- use dap instead of a plenary job to run flutter apps
		-- register_configurations = function(paths)
		--   require("dap").configurations.dart = {
		--     -- <put here config that you would find in .vscode/launch.json>
		--   }
		-- end,
	},
	-- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
	-- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
	-- fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		-- highlight = "ErrorMsg", -- highlight for the closing tag
		-- prefix = "// ", -- character to use for close tag e.g. > Widget
		enabled = true, -- set to false to disable
	},
	dev_log = {
		enabled = true,
		open_cmd = "tabedit", -- command to use to open the log buffer
	},
	dev_tools = {
		autostart = true, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "36vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		color = { -- show the derived colours for dart variables
			enabled = true, -- whether or not to highlight color variables at all, only supported on flutter >= 2.10
			background = false, -- highlight the background
			foreground = false, -- highlight the foreground
			virtual_text = true, -- show the highlight using virtual text
			virtual_text_str = "■", -- the virtual text character to highlight
		},
		on_attach = on_attach,
		capabilities = capabilities, -- e.g. lsp_status capabilities
		handlers = handlers,
		--- OR you can specify a function to deactivate or change or control how the config is created
		-- capabilities = function(config)
		--   config.specificThingIDontWant = false
		--   return config
		-- end,
		settings = {
			showTodos = false,
			completeFunctionCalls = true,
			-- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
		},
	},
})
