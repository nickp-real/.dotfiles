local M = {}

local get_pkg_path = function(lsp_name, path) return vim.fn.stdpath("data") .. "/mason/packages/" .. lsp_name .. path end

-- M.on_attach = function(client, bufnr)
--   -- local nnoremap = require("utils.keymap_utils").nnoremap
--   -- nnoremap("gd", function() vim.cmd.TSToolsGoToSourceDefinition() end)
--
--   require("tsc")
--   require("ts-error-translator")
-- end

M.settings = {
  vtsls = {
    enableMoveToFileCodeAction = true,
    autoUseWorkspaceTsdk = true,
    experimental = {
      completion = {
        enableServerSideFuzzyMatch = true,
      },
    },
    tsserver = {
      pluginPaths = { "." },
      globalPlugins = {
        {
          name = "typescript-svelte-plugin",
          location = get_pkg_path("svelte-language-server", "/node_modules/typescript-svelte-plugin"),
          enableForWorkspaceTypeScriptVersions = true,
        },
        {
          name = "@astrojs/ts-plugin",
          location = get_pkg_path("astro-language-server", "/node_modules/@astrojs/ts-plugin"),
          enableForWorkspaceTypeScriptVersions = true,
        },
        {
          name = "@vue/typescript-plugin",
          location = get_pkg_path("vue-language-server", "/node_modules/@vue/language-server"),
          languages = { "vue" },
          configNamespace = "typescript",
          enableForWorkspaceTypeScriptVersions = true,
        },
      },
    },
  },
  typescript = {
    updateImportsOnFileMove = { enabled = "always" },
    suggest = { completeFunctionCalls = true },
    preferences = { importModuleSpecifier = "non-relative" },
    inlayHints = {
      enumMemberValues = { enabled = true },
      functionLikeReturnTypes = { enabled = false },
      parameterNames = { enabled = "literals" },
      parameterTypes = { enabled = false },
      propertyDeclarationTypes = { enabled = true },
      variableTypes = { enabled = false },
    },
  },
  ["js/ts"] = { implicitProjectConfig = { checkJs = true } },
}
M.settings.javascript = M.settings.typescript

return M
