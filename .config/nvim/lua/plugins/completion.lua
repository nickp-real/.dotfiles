return {
  -- Completion
  {
    -- "hrsh7th/nvim-cmp",
    "iguanacucumber/magazine.nvim",
    name = "nvim-cmp",
    dev = true,
    event = "InsertEnter",
    dependencies = {
      -- "hrsh7th/cmp-nvim-lua",
      -- "hrsh7th/cmp-nvim-lsp",
      -- "hrsh7th/cmp-buffer",
      { "iguanacucumber/mag-nvim-lsp", name = "cmp-nvim-lsp", opts = {} },
      { "iguanacucumber/mag-nvim-lua", name = "cmp-nvim-lua" },
      { "iguanacucumber/mag-buffer", name = "cmp-buffer" },
      "https://codeberg.org/FelipeLema/cmp-async-path",
      "mtoohey31/cmp-fish",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "tabout.nvim",
      "garymjr/nvim-snippets",
    },
    config = function(_, opts)
      for _, source in ipairs(opts.sources) do
        source.group_index = source.group_index or 1
      end

      local cmp = require("cmp")

      cmp.setup.filetype("TelescopePrompt", {
        enabled = false,
      })

      cmp.setup.filetype("fish", {
        sources = cmp.config.sources({
          { name = "snippets", priority = 7 },
          { name = "fish", priority = 6 },
          { name = "async_path", priority = 6 },
          { name = "buffer", Keyword_length = 5, priority = 5 },
        }),
      })

      cmp.setup(opts)
    end,
    opts = function()
      local cmp = require("cmp")
      local defaults = require("cmp.config.default")()

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
        preselect = cmp.PreselectMode.None,
        snippet = {
          expand = function(args) vim.snippet.expand(args.body) end,
        },
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-y>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }, { "i", "c" }),
          -- ["<CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }, { "i", "c" }),
          -- ["<Tab>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif vim.snippet.active({ direction = 1 }) then
          --     vim.schedule(function() vim.snippet.jump(1) end)
          --   elseif require("neogen").jumpable() then
          --     require("neogen").jump_next()
          --   elseif check_backspace() then
          --     fallback()
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" }),
          --
          -- ["<S-Tab>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_prev_item()
          --   elseif vim.snippet.active({ direction = -1 }) then
          --     vim.schedule(function() vim.snippet.jump(-1) end)
          --   elseif require("neogen").jumpable(true) then
          --     require("neogen").jump_prev()
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" }),
        }),
        view = { entries = { follow_cursor = true } },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
          -- documentation = { border = styles.border },
        },
        formatting = {
          fields = { "kind", "abbr", "menu" },
          format = function(entry, item)
            local color_item = require("nvim-highlight-colors").format(entry, { kind = item.kind })
            -- Kind icons
            item.kind = string.format("%s", kind_icons[item.kind])
            if color_item.abbr_hl_group then
              item.kind_hl_group = color_item.abbr_hl_group
              item.kind = color_item.abbr
            end
            return item
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "snippets" },
          { name = "nvim_lua" },
        }, {
          { name = "buffer", Keyword_length = 5, option = buffer_option },
          { name = "async_path" },
        }),
        sorting = defaults.sorting,
      }
    end,
  },

  {
    -- "hrsh7th/cmp-cmdline",
    "iguanacucumber/mag-cmdline",
    name = "cmp-cmdline",
    dependencies = "nvim-cmp",
    event = "CmdlineEnter",
    config = function()
      local cmp = require("cmp")
      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ "/", "?" }, {
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        completion = { completeopt = "menu,menuone,noinsert,noselect" },
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "async_path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      })
    end,
  },
}
