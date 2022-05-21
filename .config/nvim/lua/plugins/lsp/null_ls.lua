local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local sources = {
	formatting.stylua,
	formatting.black,
	formatting.prettierd,
}

null_ls.setup({
	sources = sources,
     on_attach = function(client)
        if client.resolved_capabilities.document_formatting then
          vim.api.nvim_create_autocmd("BufWritePre", {command = "lua vim.lsp.buf.formatting_sync()"})
        end
    end,
	update_in_insert = true,
	debounce = 150,
})
