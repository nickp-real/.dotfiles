local M = {
  "neovim/nvim-lspconfig",
  event = "BufReadPre",
  dependencies = { "hrsh7th/cmp-nvim-lsp", "mason.nvim", "fidget.nvim" },
}

function M.config()
  require("lsp.config").setup()
  local lspconfig = require("lspconfig")

  local utils = require("lsp.utils")
  local root_pattern = require("lspconfig.util").root_pattern

  -- local signature_config = {
  --   hint_enable = false,
  -- }
  -- require("lsp_signature").setup(signature_config)

  local lsp_default = {
    capabilities = utils.capabilities,
    flags = utils.flags,
  }
  lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, lsp_default)

  local no_format_servers = { "gopls", "emmet_ls" }
  require("mason-lspconfig").setup_handlers({
    function(server_name)
      if no_format_servers[server_name] then
        lspconfig[server_name].setup({
          on_attach = utils.no_format_on_attach,
        })
      else
        lspconfig[server_name].setup({
          on_attach = utils.on_attach,
        })
      end
    end,

    ["sumneko_lua"] = function()
      lspconfig.sumneko_lua.setup({
        on_attach = require("lsp.servers.sumneko_lua").on_attach,
        settings = require("lsp.servers.sumneko_lua").settings,
      })
    end,

    ["pyright"] = function()
      lspconfig.pyright.setup({
        on_attach = utils.no_format_on_attach,
        settings = require("lsp.servers.pyright").settings,
      })
    end,

    ["jsonls"] = function()
      lspconfig.jsonls.setup({
        on_attach = utils.no_format_on_attach,
        settings = require("lsp.servers.jsonls").settings,
      })
    end,

    ["tsserver"] = function()
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        -- LSP Config options
        server = {
          capabilities = require("lsp.servers.tsserver").capabilities,
          on_attach = require("lsp.servers.tsserver").on_attach,
          settings = require("lsp.servers.tsserver").settings,
          flags = utils.flags,
          handlers = require("lsp.servers.tsserver").handlers,
          single_file_support = true,
        },
      })
    end,

    ["svelte"] = function()
      lspconfig.svelte.setup({
        on_attach = require("lsp.servers.svelte").on_attach,
        settings = require("lsp.servers.svelte").settings,
      })
    end,

    ["eslint"] = function()
      lspconfig.eslint.setup({
        on_attach = require("lsp.servers.eslint").on_attach,
        settings = require("lsp.servers.eslint").settings,
      })
    end,

    ["tailwindcss"] = function()
      lspconfig.tailwindcss.setup({
        capabilities = require("lsp.servers.tailwindcss").capabilities,
        filetypes = require("lsp.servers.tailwindcss").filetypes,
        on_attach = utils.no_format_on_attach,
        init_options = require("lsp.servers.tailwindcss").init_options,
        settings = require("lsp.servers.tailwindcss").settings,
        root_dir = root_pattern(unpack(require("lsp.servers.tailwindcss").root_dir)),
      })
    end,

    ["html"] = function()
      lspconfig.html.setup({
        on_attach = utils.on_attach,
        settings = require("lsp.servers.html").settings,
      })
    end,

    ["cssls"] = function()
      lspconfig.cssls.setup({
        on_attach = utils.no_format_on_attach,
        settings = require("lsp.servers.cssls").settings,
      })
    end,
  })
end

return M
