local on_snippet_forward = function()
  if require("neogen").jumpable() then
    require("neogen").jump_next()
    return true
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>:m .+1<cr>==gi", true, true, true), "tm", true)
    return true
  end
end

local on_snippet_backward = function()
  if require("neogen").jumpable(-1) then
    require("neogen").jump_prev()
    return true
  else
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<esc>:m .-2<cr>==gi", true, true, true), "tm", true)
    return true
  end
end

return {
  {
    "saghen/blink.cmp",
    build = "cargo build --release",
    event = { "InsertEnter", "CmdlineEnter" },
    opts_extend = { "sources.default" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "saghen/blink.compat", opts = {} },
      "xzbdmw/colorful-menu.nvim",
    },
    opts = function()
      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      return {
        appearance = {
          use_nvim_cmp_as_default = true,
          nerd_font_variant = "mono",
          kind_icons = {
            Text = "󰉿",
            Method = "m",
            Function = "󰊕",
            Constructor = "",
            Field = "",
            Variable = "󰆧",
            Class = "󰌗",
            Interface = "",
            Module = "",
            Property = "",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "■",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰇽",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰊄",
          },
        },
        signature = {
          enabled = true,
          window = { border = vim.g.border },
        },
        completion = {
          keyword = { range = "full" },
          trigger = {
            show_on_accept_on_trigger_character = false,
          },
          accept = {
            auto_brackets = {
              enabled = false,
            },
          },
          menu = {
            border = vim.g.border,
            draw = {
              -- columns = { { "kind_icon" }, { "label", "label_description", gap = 1 } },
              columns = { { "kind_icon" }, { "label", gap = 1 } },
              components = {
                label = {
                  text = require("colorful-menu").blink_components_text,
                  highlight = require("colorful-menu").blink_components_highlight,
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
              border = vim.g.border,
            },
          },
        },
        keymap = {
          preset = "default",
          ["<c-j>"] = {
            function(cmp)
              if cmp.snippet_active({ direction = 1 }) then
                return cmp.snippet_forward()
              else
                return on_snippet_forward()
              end
            end,
            "fallback",
          },
          ["<c-k>"] = {
            function(cmp)
              if cmp.snippet_active({ direction = -1 }) then
                return cmp.snippet_backward()
              else
                return on_snippet_backward()
              end
            end,
            "fallback",
          },
        },
        sources = {
          per_filetype = {
            lua = { "lazydev", "lsp", "path", "snippets", "buffer" },
          },
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
            lsp = { fallbacks = { "snippets", "buffer" } },
            path = { fallbacks = { "snippets", "buffer" } },
            buffer = { min_keyword_length = 4 },
          },
        },
      }
    end,
  },

  -- snippets
  {
    "danymat/neogen",
    cmd = "Neogen",
    opts = { snippet_engine = "nvim" },
  },
}
