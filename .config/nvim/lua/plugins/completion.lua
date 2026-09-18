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
    version = "1.*",
    event = { "InsertEnter", "CmdwinEnter" },
    opts_extend = { "sources.default" },
    dependencies = {
      "rafamadriz/friendly-snippets",
      { "saghen/blink.compat", opts = {} },
      "xzbdmw/colorful-menu.nvim",
      { "mikavilpas/blink-ripgrep.nvim", version = "*" },
    },
    opts = function()
      local default_source = { "lsp", "path", "snippets", "buffer", "ripgrep" }

      ---@module 'blink.cmp'
      ---@type blink.cmp.Config
      return {
        appearance = {
          nerd_font_variant = "mono",
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
                kind_icons = {
                  ellipsis = false,
                  text = function(ctx)
                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                    return kind_icon
                  end,
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
        cmdline = {
          completion = {
            menu = {
              auto_show = true,
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
          default = default_source,
          per_filetype = {
            lua = table.insert(default_source, 1, "lazydev"),
          },
          providers = {
            -- dont show LuaLS require statements when lazydev has items
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
            lsp = { fallbacks = {}, async = true },
            path = { fallbacks = { "buffer" } },
            buffer = { min_keyword_length = 4 },
            ripgrep = {
              module = "blink-ripgrep",
              name = "Ripgrep",
              score_offset = -10,
              ---@module "blink-ripgrep"
              ---@type blink-ripgrep.Options
              opts = { backend = { use = "gitgrep-or-ripgrep" } },
            },
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
