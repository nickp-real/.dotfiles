local styles = require("core.styles")
return {
  -- Snippet Engine
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
      config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
    },
    config = function(_, opts)
      local luasnip = require("luasnip")

      luasnip.setup(opts)

      -- luasnip.filetype_extend("dart", { "flutter" })
      luasnip.add_snippets("cpp", require("snippets.cpp"))
    end,
    opts = {
      history = true,
      update_events = { "InsertLeave", "TextChanged", "TextChangedI" },
      region_check_events = { "CursorHold", "InsertEnter" },
      delete_check_events = { "TextChanged" },
      -- enable_autosnippets = true,
    },
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "FelipeLema/cmp-async-path",
      "hrsh7th/cmp-cmdline",
      "mtoohey31/cmp-fish",
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "tabout.nvim",
      "chrisgrieser/cmp_yanky",
    },
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

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

      return {
        -- enabled = function()
        --   -- disable completion in comments
        --   local context = require("cmp.config.context")
        --   -- keep command mode completion enabled when cursor is in a comment
        --   if vim.api.nvim_get_mode().mode == "c" then
        --     return true
        --   else
        --     return not context.in_treesitter_capture("comment") and not context.in_syntax_group("Comment")
        --   end
        -- end,
        preselect = cmp.PreselectMode.None,
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
          end,
        },
        confirm_opts = {
          behavior = cmp.ConfirmBehavior.Replace,
          select = false,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
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
              cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
            elseif require("luasnip").jumpable(-1) and require("luasnip").expand_or_locally_jumpable() then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
            elseif require("neogen").jumpable(true) then
              require("neogen").jump_prev()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        view = { entries = { follow_cursor = true } },
        window = {
          -- completion = cmp.config.window.bordered(),
          -- documentation = cmp.config.window.bordered(),
          documentation = vim.tbl_deep_extend(
            "force",
            require("cmp.config.default")().window.documentation,
            { border = styles.border }
          ),
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
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
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "async_path" },
          {
            name = "buffer",
            Keyword_length = 5,
            option = buffer_option,
          },
          { name = "luasnip" },
          { name = "nvim_lua" },
          { name = "cmp_yanky" },
        }),
        comparators = {
          function(entry1, entry2)
            local kind1 = entry1:get_kind()
            local kind2 = entry2:get_kind()
            kind1 = kind1 == cmp.types.lsp.CompletionItemKind.Text and 100 or kind1
            kind2 = kind2 == cmp.types.lsp.CompletionItemKind.Text and 100 or kind2
            if kind1 ~= kind2 then
              if kind1 == cmp.types.lsp.CompletionItemKind.Snippet then return false end
              if kind2 == cmp.types.lsp.CompletionItemKind.Snippet then return true end
              local diff = kind1 - kind2
              if diff < 0 then
                return true
              elseif diff > 0 then
                return false
              end
            end
            return nil
          end,
          function(entry1, entry2)
            local _, entry1_under = entry1.completion_item.label:find("^_+")
            local _, entry2_under = entry2.completion_item.label:find("^_+")
            entry1_under = entry1_under or 0
            entry2_under = entry2_under or 0
            if entry1_under > entry2_under then
              return false
            elseif entry1_under < entry2_under then
              return true
            end
          end,
          -- cmp.config.compare.kind,
          cmp.config.compare.score,
          cmp.config.compare.scopes,
          cmp.config.compare.recently_used,
          cmp.config.compare.sort_text,
          cmp.config.compare.exact,
          cmp.config.compare.offset,
          cmp.config.compare.locality,
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
      opts = { enable_autocmd = false },
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
          function() return require("dial.map").inc_normal() end,
          desc = "Increment",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "<C-x>",
          function() return require("dial.map").dec_normal() end,
          desc = "Decrement",
          expr = true,
          mode = { "n", "v" },
        },
        {
          "g<C-a>",
          function() return require("dial.map").inc_gvisual() end,
          desc = "Gvisual Increment",
          expr = true,
          mode = "v",
        },
        {
          "g<C-x>",
          function() return require("dial.map").dec_gvisual() end,
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
          augend.semver.alias.semver,
          augend.constant.new({ elements = { "let", "const" } }),
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
    ft = { "html", "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte", "python" },
    opts = {
      remove_template_string = true, -- remove backticks when there are no template string
      restore_quotes = {
        -- quotes used when "remove_template_string" option is enabled
        normal = [["]],
        jsx = [["]],
      },
    },
  },

  -- Split & Join
  {
    "Wansmer/treesj",
    keys = { { "J", "<cmd>TSJToggle<cr>", desc = "Split & Join" } },
    opts = { use_default_keymaps = false },
  },

  {
    "gbprod/yanky.nvim",
    dependencies = { { "kkharji/sqlite.lua", enabled = not jit.os:find("Windows") } },
    opts = {
      highlight = { timer = 250 },
      ring = { storage = jit.os:find("Windows") and "shada" or "sqlite" },
    },
    keys = {
      {
        "<leader>p",
        function() require("telescope").extensions.yank_history.yank_history({}) end,
        desc = "Open Yank History",
      },
      { "y", "<Plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after selection" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before selection" },
      { "[y", "<Plug>(YankyCycleForward)", desc = "Cycle forward through yank history" },
      { "]y", "<Plug>(YankyCycleBackward)", desc = "Cycle backward through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },
}
