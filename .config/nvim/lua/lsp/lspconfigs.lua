-- local nullLs_diagnostic = { "pyright", "tsserver" }
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

vim.diagnostic.config(diagnostic_config)

local utils = require("lsp.utils")
local lspconfig = require("lspconfig")

local servers = { "bashls", "pyright", "jsonls", "tsserver", "eslint", "html" }
for _, lsp in pairs(servers) do
	lspconfig[lsp].setup({
		capabilities = utils.capabilities,
		on_attach = utils.on_attach,
		handlers = utils.handlers,
		flags = utils.flags,
	})
end

lspconfig.sumneko_lua.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
	settings = require("lsp.servers.sumneko_lua").settings,
})

lspconfig.pyright.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
})

lspconfig.tsserver.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
})

lspconfig.ccls.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
})

lspconfig.jsonls.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
})

lspconfig.html.setup({
	capabilities = utils.capabilities,
	on_attach = require("lsp.servers.null-ls-format").on_attach,
	handlers = utils.handlers,
	flags = utils.flags,
})
