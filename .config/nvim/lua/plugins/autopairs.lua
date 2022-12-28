local M = {
  "windwp/nvim-autopairs",
  event = "InsertCharPre",
}

function M.config()
  local nvim_autopairs = require("nvim-autopairs")

  nvim_autopairs.setup({
    disable_filetype = { "TelescopePrompt", "vim" },
    check_ts = true,
    ts_config = {
      lua = { "string", "source" },
      javascript = { "string", "template_string" },
      java = false,
    },
    fast_wrap = {},
    -- enable_check_bracket_line = false,
  })

  -- local rule = require("nvim-autopairs.rule")

  -- nvim_autopairs.add_rules({
  --   rule("%<%>$", "</>", { "typescript", "typescriptreact", "javascript", "javascriptreact" }):use_regex(true),
  -- })
end

return M
