local formatters_by_ft = {
  lua = { "stylua" },
  python = { "black" },
  javascript = { "prettierd" },
  typescript = { "prettierd" },
  javascriptreact = { "prettierd" },
  typescriptreact = { "prettierd" },
  vue = { "prettierd" },
  astro = { "prettierd" },
  svelte = { "prettierd" },
  markdown = { "prettierd" },
  go = { "gofumpt", "goimports-reviser", "golines" },
  bash = { "shfmt" },
  sh = { "shfmt" },
  json = { "jq" },
  -- Use the "*" filetype to run formatters on all filetypes.
  -- ["*"] = { "codespell" },
  -- Use the "_" filetype to run formatters on filetypes that don't
  -- have other formatters configured.
  -- ["_"] = { "trim_whitespace", "trim_newlines" },
}

return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    cmd = "ConformInfo",
    keys = {
      {
        "=",
        function()
          require("conform").format({ async = true }, function(err)
            if not err then
              if vim.startswith(vim.api.nvim_get_mode().mode:lower(), "v") then
                vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "n", true)
              end
            end
          end)
        end,
        mode = { "n", "v" },
        desc = "Format Buffer",
      },
      {
        "<leader>f",
        function() require("conform").format() end,
        desc = "[F]ormat",
      },
      {
        "<leader>fe",
        require("plugins.lsp.config").toggle_auto_format,
        expr = true,
        desc = "[F]ormat [E]nable/Disable",
      },
    },
    init = function() vim.o.formatexpr = "v:lua.require'conform'.formatexpr()" end,
    opts = {
      formatters_by_ft = formatters_by_ft,
      default_format_opts = {
        lsp_format = "fallback",
        timeout_ms = 3000,
        async = false,
        quite = false,
      },
      -- If this is set, Conform will run the formatter on save.
      -- It will pass the table to conform.format().
      -- This can also be a function that returns the table.
      format_on_save = function(bufnr)
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then return end
        return {}
      end,
      formatters = {
        jq = { prepend_args = { "--sort-keys" } },
      },
    },
  },
}
