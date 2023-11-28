local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/bin/jdtls"

local config = {
  cmd = { jdtls_path },
  root_dir = vim.fs.dirname(vim.fs.find({ ".gradlew", ".git", "mvnw" }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    -- require("lsp.utils").on_attach(client, bufnr)
  end,

  -- capabilities = require("lsp.utils").capabilities,
}

jdtls.start_or_attach(config)
