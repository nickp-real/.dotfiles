return {
  -- Snippet engine & Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
    config = function(_, opts)
      local luasnip = require("luasnip")

      luasnip.setup(opts)

      luasnip.snippets = {
        all = {},
        html = {},
      }

      -- enable html snippets in javascript/typescript (REACT)
      luasnip.filetype_extend("javascriptreact", { "html" })
      luasnip.filetype_extend("typescriptreact", { "html" })

      -- luasnip.filetype_extend("dart", { "flutter" })
      luasnip.add_snippets("cpp", require("snippet.cpp"))

      local luasnip_fix_group = vim.api.nvim_create_augroup("LuaSnipHistory", { clear = true })
      vim.api.nvim_create_autocmd("ModeChanged", {
        callback = function()
          if
            ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n") or vim.v.event.old_mode == "i")
            and luasnip.session.current_nodes[vim.api.nvim_get_current_buf()]
            and not luasnip.session.jump_active
          then
            luasnip.unlink_current()
          end
        end,
        group = luasnip_fix_group,
      })
    end,
    opts = {
      history = true,
      update_events = "InsertLeave,TextChanged,TextChangedI",
      region_check_events = "CursorHold,InsertLeave,InsertEnter",
      delete_check_events = "TextChanged,InsertEnter",
      enable_autosnippets = true,
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "lukas-reineke/cmp-under-comparator",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      { "mtoohey31/cmp-fish", ft = "fish" },
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "tabout.nvim",
    },
    config = function(_, opts)
      local cmp = require("cmp")
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

      cmp.setup(opts)
    end,
    opts = function()
      local cmp = require("cmp")
      local compare = cmp.config.compare

      -- Autopairs
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

      local kind_icons = {
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
        Color = "󰏘",
        File = "󰈙",
        Reference = "",
        Folder = "󰉋",
        EnumMember = "",
        Constant = "󰇽",
        Struct = "",
        Event = "",
        Operator = "󰆕",
        TypeParameter = "󰊄",
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

      return {
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
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
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
            elseif require("luasnip").expand_or_locally_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
            elseif require("neogen").jumpable() then
              require("neogen").jump_next()
            elseif check_backspace() then
              fallback()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) and require("luasnip").expand_or_locally_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            elseif require("neogen").jumpable(true) then
              require("neogen").jump_prev()
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
          fields = { "kind", "abbr" },
          format = function(entry, vim_item)
            -- Kind icons
            vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
            -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
            -- vim_item.menu = ({
            --   nvim_lsp = "[LSP]",
            --   luasnip = "[Snippet]",
            --   buffer = "[Buffer]",
            --   nvim_lua = "[Nvim_lua]",
            --   path = "[Path]",
            -- })[entry.source.name]
            return require("tailwindcss-colorizer-cmp").formatter(entry, vim_item)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help", priority = 8 },
          { name = "nvim_lsp", max_item_count = 25, priority = 8 },
          { name = "luasnip", priority = 7, max_item_count = 8 },
          {
            name = "buffer",
            Keyword_length = 5,
            priority = 7,
            option = buffer_option,
            max_item_count = 8,
          },
          { name = "nvim_lua", priority = 5 },
          { name = "path", priority = 4 },
        }),
        preselect = cmp.PreselectMode.None,
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
      }
    end,
  },

  -- Autopair
  {
    "windwp/nvim-autopairs",
    event = "InsertCharPre",
    opts = {
      disable_filetype = { "TelescopePrompt", "vim" },
      check_ts = true,
      ts_config = {
        lua = { "string", "source" },
        javascript = { "string", "template_string" },
        java = false,
      },
      fast_wrap = {},
      -- enable_check_bracket_line = false,
    },
  },

  -- Surround pair
  {
    "kylechui/nvim-surround",
    keys = { "cs", "ds", "ys", "yS", { "S", mode = "x" }, { "gS", mode = "x" } },
    config = true,
  },

  -- Comment
  {
    "numToStr/Comment.nvim",
    keys = {
      { "gc", mode = { "n", "x" }, desc = "Line Comment" },
      { "gb", mode = { "n", "x" }, desc = "Block Comment" },
    },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = function()
      return {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        ignore = "^$",
        toggler = {
          ---Line-comment toggle keymap
          line = "gcc",
          ---Block-comment toggle keymap
          block = "gbc",
        },
      }
    end,
  },

  -- Toggle between word
  {
    "monaqa/dial.nvim",
    keys = function()
      return {
        {
          "<C-a>",
          function()
            return require("dial.map").inc_normal()
          end,
          desc = "Increment",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "<C-x>",
          function()
            return require("dial.map").dec_normal()
          end,
          desc = "Decrement",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "g<C-a>",
          function()
            return require("dial.map").inc_gvisual()
          end,
          desc = "Gvisual Increment",
          expr = true,
          mode = "v",
        },
        {
          "g<C-x>",
          function()
            return require("dial.map").dec_gvisual()
          end,
          desc = "Gvisual Decrement",
          expr = true,
          mode = "v",
        },
      }
    end,
    config = function()
      local augend = require("dial.augend")
      require("dial.config").augends:register_group({
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.constant.alias.bool,
        },
      })
    end,
  },

  -- Tabout
  {
    "abecodes/tabout.nvim",
    opts = {
      act_as_shift_tab = true,
      tabouts = {
        { open = "'", close = "'" },
        { open = '"', close = '"' },
        { open = "`", close = "`" },
        { open = "(", close = ")" },
        { open = "[", close = "]" },
        { open = "{", close = "}" },
        { open = '["', close = '"]' },
      },
    },
  },

  -- Template string for js, jsx, ts, tsx
  {
    "axelvc/template-string.nvim",
    keys = "$",
    ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    opts = {
      remove_template_string = true, -- remove backticks when there are no template string
      restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [["]],
        jsx = [["]],
      },
    },
  },

  -- Swap args
  {
    "mizlan/iswap.nvim",
    cmd = "ISwap",
    keys = { { "<leader>sw", "<cmd>ISwap<cr>", desc = "Swap Param" } },
    opts = { autoswap = true },
  },

  -- Split & Join
  {
    "Wansmer/treesj",
    cmd = "TSJToggle",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split & Join" } },
    opts = { use_default_keymaps = false },
  },
}
