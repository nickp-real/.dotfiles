local cmp_status_ok, cmp = pcall(require, "cmp")
local luasnip_status_ok, luasnip = pcall(require, "luasnip")
local neogen_status_ok, neogen = pcall(require, "neogen")

if not (cmp_status_ok and luasnip_status_ok and neogen_status_ok) then
  return
end

local compare = cmp.config.compare

local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

local cmp_window = require("cmp.utils.window")

cmp_window.info_ = cmp_window.info
cmp_window.info = function(self)
  local info = self:info_()
  info.scrollable = false
  return info
end

local check_backspace = function()
  local col = vim.fn.col(".") - 1
  return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local buffer_option = {
  -- Complete from all visible buffers (splits)
  get_bufnrs = function()
    local bufs = {}
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      bufs[vim.api.nvim_win_get_buf(win)] = true
    end
    return vim.tbl_keys(bufs)
  end,
}

local types = require("cmp.types")

local function deprioritize_snippet(entry1, entry2)
  if entry1:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return false
  end
  if entry2:get_kind() == types.lsp.CompletionItemKind.Snippet then
    return true
  end
end

cmp.setup({
  enabled = function()
    -- disable completion in comments
    local context = require("cmp.config.context")
    -- keep command mode completion enabled when cursor is in a comment
    if vim.api.nvim_get_mode().mode == "c" then
      return true
    else
      return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
    end
  end,

  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  -- confirm_opts = {
  --   behavior = cmp.ConfirmBehavior.Replace,
  --   select = false,
  -- },

  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif neogen.jumpable() then
        neogen.jump_next()
      -- elseif check_backspace() then
      --   cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) and luasnip.expand_or_locally_jumpable() then
        luasnip.jump(-1)
      elseif neogen.jumpable(true) then
        neogen.jump_prev()
      elseif check_backspace() then
        fallback()
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  window = {
    -- completion = {
    --   winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
    --   col_offset = -3,
    --   side_padding = 0,
    -- },
    -- completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(_, vim_item)
      vim_item.kind = string.format("%s %s", kind_icons[vim_item.kind], vim_item.kind)
      local strings = vim.split(vim_item.kind, "%s", { trimepty = true })
      vim_item.kind = strings[1]
      vim_item.menu = "  (" .. strings[2] .. ")"
      return vim_item
    end,
  },
  sources = cmp.config.sources({
    -- { name = "nvim_lsp_signature_help", priority = 8 },
    { name = "nvim_lsp", max_item_count = 25, priority = 8 },
    { name = "luasnip", priority = 7, max_item_count = 8 },
    { name = "buffer", Keyword_length = 5, priority = 7, option = buffer_option, max_item_count = 8 },
    { name = "nvim_lua", priority = 5 },
    { name = "path", priority = 4 },
  }),
  preselete = cmp.PreselectMode.None,
  sorting = {
    priority_weight = 1.0,
    comparators = {
      -- deprioritize_snippet,
      compare.offset,
      compare.score, -- based on :  score = score + ((#sources - (source_index - 1)) * sorting.priority_weight)
      compare.locality,
      compare.recently_used,
      require("cmp-under-comparator").under,
      compare.order,
      -- cmp.config.compare.exact,
      -- cmp.config.compare.locality,
      -- cmp.config.compare.score,
      -- cmp.config.compare.recently_used,
      -- cmp.config.compare.offset,
      -- cmp.config.compare.sort_text,
      -- cmp.config.compare.order,
    },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = "buffer" },
  },
})

-- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = "path" },
  }, {
    { name = "cmdline" },
  }),
})

cmp.setup.filetype("TelescopePrompt", {
  enabled = false,
})

cmp.setup.filetype("fish", {
  sources = cmp.config.sources({
    { name = "luasnip", priority = 7 },
    { name = "fish", priority = 6 },
    { name = "path", priority = 6 },
    { name = "buffer", Keyword_length = 5, priority = 5 },
  }),
})
