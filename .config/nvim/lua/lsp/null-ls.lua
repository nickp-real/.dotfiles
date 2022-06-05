local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.stylua,
	formatting.black,
	formatting.prettierd,
	-- diagnostics.eslint_d,
}

null_ls.setup({
	sources = sources,
	on_attach = function(client)
		if client.resolved_capabilities.document_formatting then
			local group = vim.api.nvim_create_augroup("Format", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", { command = "lua vim.lsp.buf.formatting_sync()", group = group })
		end
	end,
	update_in_insert = false,
	debounce = 150,
})
