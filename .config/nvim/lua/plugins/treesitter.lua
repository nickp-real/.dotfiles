return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    event = { "BufReadPost", "BufNewFile", "BufWritePre", "VeryLazy" },
    build = ":TSUpdate",
    cmd = { "TSUpdate", "TSInstall", "TSLog", "TSUninstall" },
    dependencies = {
      {
        "andymass/vim-matchup",
        init = function() vim.g.matchup_matchparen_offscreen = { method = "popup", border = vim.g.border } end,
      },
      { "nvim-treesitter/nvim-treesitter-context", opts = { max_lines = 4, trim_scope = "inner", separator = "━" } },
    },
    config = function(_, opts)
      local ts = require("nvim-treesitter")
      ts.setup(opts)

      local already_installed = ts.get_installed()
      local to_install = vim
        .iter(opts.ensure_installed)
        :filter(function(parser) return not vim.tbl_contains(already_installed, parser) end)
        :totable()

      if #to_install > 0 then ts.install(to_install) end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("treesitter_filetype", { clear = true }),
        callback = function(ev)
          local ft = ev.match
          if not vim.tbl_contains(opts.ensure_installed, ft) then return end

          pcall(vim.treesitter.start, ev.buf)
          vim.api.nvim_set_option_value(
            "indentexpr",
            "v:lua.require'nvim-treesitter'.indentexpr()",
            { scope = "local" }
          )
        end,
      })
    end,
    opts = {
      ensure_installed = {
        "fish",
        "bash",
        "lua",
        "luadoc",
        "html",
        "typescript",
        "typescriptreact",
        "javascript",
        "javascriptreact",
        "vim",
        "vimdoc",
        "markdown",
        "markdown_inline",
        "json",
        "jsonc",
        "yaml",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
  },

  -- Auto tag
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },

  -- Comment
  {
    "folke/ts-comments.nvim",
    event = "VeryLazy",
    opts = { lang = { prisma = "// %s" } },
  },
}
