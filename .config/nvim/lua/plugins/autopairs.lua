local nvim_autopairs_status_ok, nvim_autopairs = pcall(require, "nvim-autopairs")
local cmp_status_ok, cmp = pcall(require, "cmp")
if not (nvim_autopairs_status_ok and cmp_status_ok) then
  return
end

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

local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
