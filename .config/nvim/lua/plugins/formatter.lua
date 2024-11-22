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
  go = { "goimports-reviser", "gofumpt", "golines" },
  bash = { "shfmt" },
  sh = { "shfmt" },
  json = { "jq" },
  -- Use the "*" filetype to run formatters on all filetypes.
  -- ["*"] = { "codespell" },
  -- Use the "_" filetype to run formatters on filetypes that don't
  -- have other formatters configured.
  -- ["_"] = { "trim_whitespace", "trim_newlines" },
}

local autoformat_setup = function()
  vim.api.nvim_create_user_command("FormatDisable", function(args)
    if args.bang then
      -- FormatDisable! will disable formatting just for this buffer
      vim.b.disable_autoformat = true
    else
      vim.g.disable_autoformat = true
    end
    vim.notify("Disabled format on save", vim.log.levels.INFO, { title = "Format" })
  end, {
    desc = "Disable autoformat-on-save",
    bang = true,
  })
  vim.api.nvim_create_user_command("FormatEnable", function()
    vim.b.disable_autoformat = false
    vim.g.disable_autoformat = false
    vim.notify("Enabled format on save", vim.log.levels.INFO, { title = "Format" })
  end, {
    desc = "Re-enable autoformat-on-save",
  })
end

local toggle_auto_format = function()
  if vim.g.disable_autoformat or vim.b.disable_autoformat then
    return "<cmd>FormatEnable<cr>"
  else
    return "<cmd>FormatDisable<cr>"
  end
end

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
        toggle_auto_format,
        expr = true,
        desc = "[F]ormat [E]nable/Disable",
      },
    },
    init = function()
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
      autoformat_setup()
    end,
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
