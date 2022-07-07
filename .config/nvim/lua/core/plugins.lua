local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  vim.api.nvim_command([[packadd packer.nvim]])
end

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("PACKER", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile",
})

local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

return packer.startup({
  function()
    -------------
    -- Startup --
    -------------

    use({
      -- Packer
      "wbthomason/packer.nvim",

      -- Load first
      "lewis6991/impatient.nvim",
      "nathom/filetype.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-lua/popup.nvim",
      "kyazdani42/nvim-web-devicons",
      {
        "goolord/alpha-nvim",
        config = function()
          require("plugins.alpha")
        end,
      },

      -- Discord Presence
      { "andweeb/presence.nvim", event = "BufRead" },
    })

    ---------------------------------
    -- Theme, Statusbar, Bufferbar --
    ---------------------------------

    use({
      {
        "ful1e5/onedark.nvim",
        config = function()
          require("plugins.onedark")
        end,
      },
      {
        "akinsho/bufferline.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        after = "onedark.nvim",
        config = function()
          require("plugins.bufferline")
        end,
      },
      {
        {
          "nvim-lualine/lualine.nvim",
          requires = { "kyazdani42/nvim-web-devicons", opt = true },
          after = "onedark.nvim",
          config = function()
            require("plugins.lualine")
          end,
        },

        -- LSP progress indicator
        {
          "j-hui/fidget.nvim",
          after = "lualine.nvim",
          config = function()
            require("plugins.fidget")
          end,
        },
      },

      -- Float UI
      {
        "stevearc/dressing.nvim",
        config = function()
          require("plugins.dressing")
        end,
      },
    })

    ----------------
    -- Treesitter --
    ----------------

    use({
      {
        "nvim-treesitter/nvim-treesitter",
        event = "BufRead",
        run = ":TSUpdate",
        config = function()
          require("plugins.treesitter")
        end,
      },
      { "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
      { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },
      { "RRethy/nvim-treesitter-textsubjects", after = "nvim-treesitter" },
      { "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
      {
        "andymass/vim-matchup",
        after = "nvim-treesitter",
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup", border = "rounded" }
        end,
      },
      { "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
      {
        "lewis6991/spellsitter.nvim",
        after = "nvim-treesitter",
        event = "BufRead",
        config = function()
          require("plugins.spellsitter")
        end,
      },
    })

    -- Log Highlight
    use({ "MTDL9/vim-log-highlighting", event = "BufRead", ft = "log" })

    --------
    -- UI --
    --------

    use({
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function()
        require("plugins.indent-blankline")
      end,
    })

    use({
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
        require("plugins.colorizer")
      end,
    })

    use({
      "lewis6991/gitsigns.nvim",
      event = "BufRead",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.gitsigns")
      end,
    })

    use({
      "folke/todo-comments.nvim",
      event = "BufRead",
      requires = "nvim-lua/plenary.nvim",
      config = function()
        require("plugins.todo-comment")
      end,
    })

    use({
      "m-demare/hlargs.nvim",
      after = "nvim-treesitter",
      event = "BufRead",
      config = function()
        require("plugins.hlargs")
      end,
    })

    ----------------
    -- Navigation --
    ----------------

    use({
      "kyazdani42/nvim-tree.lua",
      event = "CursorHold",
      config = function()
        require("plugins.nvim-tree")
      end,
    })

    use({
      {
        "nvim-telescope/telescope.nvim",
        requires = "nvim-lua/plenary.nvim",
        event = "CursorHold",
        config = function()
          require("plugins.telescope")
        end,
      },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        run = "make",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("fzf")
        end,
      },
      {
        "nvim-telescope/telescope-file-browser.nvim",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("file_browser")
        end,
      },
      {
        "nvim-telescope/telescope-media-files.nvim",
        after = "telescope.nvim",
        config = function()
          require("telescope").load_extension("media_files")
        end,
      },
    })

    use({
      "phaazon/hop.nvim",
      branch = "v2", -- optional but strongly recommended
      event = "BufRead",
      config = function()
        require("plugins.hop")
      end,
    })

    use({
      "karb94/neoscroll.nvim",
      event = "BufEnter",
      config = function()
        require("plugins.neoscroll")
      end,
    })

    -- Terminal
    use({
      "akinsho/toggleterm.nvim",
      event = "CursorHold",
      config = function()
        require("plugins.toggleterm")
      end,
    })

    ---------
    -- LSP --
    ---------

    use({
      {
        "neovim/nvim-lspconfig",
        requires = {
          "hrsh7th/cmp-nvim-lsp",
          "williamboman/nvim-lsp-installer",
          "lukas-reineke/lsp-format.nvim",
          "jose-elias-alvarez/nvim-lsp-ts-utils",
          "b0o/SchemaStore.nvim",
          {
            "RRethy/vim-illuminate",
            config = function()
              require("plugins.vim-illuminate")
            end,
          },
        },
        event = "BufRead",
        config = function()
          require("lsp.config")
          require("lsp.lspconfigs")
        end,
      },
      {
        "jose-elias-alvarez/null-ls.nvim",
        requires = "lukas-reineke/lsp-format.nvim",
        event = "BufRead",
        config = function()
          require("lsp.null-ls")
        end,
      },
    })

    -- Flutter
    use({
      {
        "akinsho/flutter-tools.nvim",
        requires = { "nvim-lua/plenary.nvim", "lukas-reineke/lsp-format.nvim" },
        event = "BufRead",
        ft = { "flutter", "dart" },
        config = function()
          require("lsp.flutter")
        end,
      },
      {
        "akinsho/pubspec-assist.nvim",
        requires = "plenary.nvim",
        rocks = {
          {
            "lyaml",
            server = "http://rocks.moonscript.org",
            -- If using macOS or Ubuntu, you may need to install the `libyaml` package.
            -- if you install libyaml with homebrew you will need to set the YAML_DIR
            -- to the location of the homebrew installation of libyaml e.g.
            -- env = { YAML_DIR = '/opt/homebrew/Cellar/libyaml/0.2.5/' },
          },
        },
        ft = { "dart", "flutter", "yaml" },
        config = function()
          require("plugins.pubspec-assist")
        end,
      },
      { "RobertBrunhage/flutter-riverpod-snippets", ft = { "flutter", "dart" }, after = "nvim-cmp" },
    })

    ---------------
    -- LSP Addon --
    ---------------

    use({
      "folke/trouble.nvim",
      event = "CursorHold",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
        require("plugins.trouble")
      end,
    })
    -- use("mfussenegger/nvim-lint")

    ----------------
    -- Completion --
    ----------------

    use({
      {
        "hrsh7th/nvim-cmp",
        event = { "InsertEnter", "CmdLineEnter" },
        config = function()
          require("plugins.cmp")
        end,
        requires = {
          {
            "L3MON4D3/LuaSnip",
            event = "CursorHold",
            config = function()
              require("plugins.luasnip")
            end,
            requires = "rafamadriz/friendly-snippets",
          },
          {
            "danymat/neogen",
            requires = "nvim-treesitter/nvim-treesitter",
            config = function()
              require("plugins.neogen")
            end,
          },
          "lukas-reineke/cmp-under-comparator",
        },
      },
      { "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
      { "hrsh7th/cmp-buffer", after = "nvim-cmp" },
      { "hrsh7th/cmp-path", after = "nvim-cmp" },
      { "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
      { "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
      { "mtoohey31/cmp-fish", after = "nvim-cmp", ft = "fish" },
      { "petertriho/cmp-git", after = "nvim-cmp", ft = { "gitcommit", "octo" }, requires = "nvim-lua/plenary.nvim" },
    })

    -------------
    -- Editing --
    -------------

    use({
      "numToStr/Comment.nvim",
      event = "BufRead",
      config = function()
        require("plugins.comment")
      end,
    })

    use({
      "abecodes/tabout.nvim",
      requires = "nvim-treesitter",
      after = "nvim-cmp",
      config = function()
        require("plugins.tabout")
      end,
    })

    use({
      "tpope/vim-surround",
      event = "CursorHold",
    })

    use({
      "tpope/vim-repeat",
      event = "CursorHold",
    })

    use({
      "windwp/nvim-autopairs",
      event = "InsertCharPre",
      after = { "nvim-treesitter", "nvim-cmp" },
      config = function()
        require("plugins.autopairs")
      end,
    })

    ---------
    -- Git --
    ---------

    use({ "tpope/vim-fugitive", event = "CursorHold" })

    ----------------------------
    -- Debug Adapter Protocol --
    ----------------------------

    use({
      "rcarriga/nvim-dap-ui",
      event = "BufRead",
      requires = {
        {
          "mfussenegger/nvim-dap",
          config = function()
            require("plugins.dap")
          end,
        },
      },
    })

    ---------------
    -- Previewer --
    ---------------

    -- Markdown
    use({
      { "ellisonleao/glow.nvim", event = "CursorHold", ft = "markdown" },
      {
        "iamcco/markdown-preview.nvim",
        event = "CursorHold",
        ft = "markdown",
        run = "cd app && yarn install",
        cmd = "MarkdownPreview",
      },
    })

    -- HTML
    use({
      "turbio/bracey.vim",
      event = "CursorHold",
      ft = { "html", "css", "javascript" },
      run = "npm install --prefix server",
      config = function()
        vim.g.bracey_refresh_on_save = 1
      end,
    })

    -------------
    -- Utility --
    -------------

    use({
      "simrat39/symbols-outline.nvim",
      event = "CursorHold",
      config = function()
        require("plugins.symbol-outline")
      end,
    })

    use({
      "Shatur/neovim-session-manager",
      event = "BufWinEnter",
      config = function()
        require("plugins.session-manager")
      end,
    })

    use({ "dstein64/vim-startuptime", cmd = "StartupTime" })
    use({ "wsdjeg/vim-fetch", event = "CursorHold" })
    use({ "famiu/bufdelete.nvim", event = "BufRead" })
    use({
      "kwkarlwang/bufresize.nvim",
      event = "BufRead",
      config = function()
        require("plugins.bufresize")
      end,
    })
    use({
      "jghauser/mkdir.nvim",
      event = "BufRead",
    })

    if PACKER_BOOSTRAP then
      require("packer").sync()
    end
  end,
})
