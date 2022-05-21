local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local packer = require("packer")

if fn.empty(fn.glob(install_path)) > 0 then
	packer_boostrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
end

packer.init({
	config = {
		display = {
			open_fn = function()
				return require("packer.util").float({ border = "rounded" })
			end,
		},
	},
})

return packer.startup({
	function()
		-- Packer
		use("wbthomason/packer.nvim")

		-- Theme
		use("kyazdani42/nvim-web-devicons")
		use("ful1e5/onedark.nvim")
		use({
			"nvim-lualine/lualine.nvim",
			requires = { "kyazdani42/nvim-web-devicons", opt = true },
		})
		use("nvim-lua/plenary.nvim")
		use("nvim-lua/popup.nvim")
		use("goolord/alpha-nvim")

		-- Discord Presence
		use("andweeb/presence.nvim")

		-- IDE
		use("lukas-reineke/indent-blankline.nvim")
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use("j-hui/fidget.nvim")
		use("jose-elias-alvarez/null-ls.nvim")
		use("akinsho/toggleterm.nvim")
		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
		})
		use("famiu/bufdelete.nvim")
		use({
			"kwkarlwang/bufresize.nvim",
			config = function()
				require("bufresize").setup()
			end,
		})
		use("abecodes/tabout.nvim")
		use("m-demare/hlargs.nvim")
		use("stevearc/dressing.nvim")
		use("kyazdani42/nvim-tree.lua")
		use("karb94/neoscroll.nvim")
		use({
			"danymat/neogen",
			config = function()
				require("neogen").setup({
					snippet_engine = "luasnip",
				})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		})

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
		use("windwp/nvim-ts-autotag")
		use("p00f/nvim-ts-rainbow")
		use("windwp/nvim-autopairs")
		use("nvim-treesitter/nvim-treesitter-textobjects")
		use("JoosepAlviste/nvim-ts-context-commentstring")
		use("andymass/vim-matchup")

		-- Log Highlight
		use("MTDL9/vim-log-highlighting")

		-- Surround
		use({
			"ur4ltz/surround.nvim",
			config = function()
				require("surround").setup({ mappings_style = "surround" })
			end,
		})

		-- Comment
		use({
			"numToStr/Comment.nvim",
		})

		-- Completion
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/nvim-cmp")
		use("lukas-reineke/cmp-rg")
		use("hrsh7th/cmp-nvim-lsp-signature-help")

		-- Snippet Engine
		use("L3MON4D3/LuaSnip")
		use("saadparwaiz1/cmp_luasnip")
		use("rafamadriz/friendly-snippets")

		-- Telescope
		use({
			"nvim-telescope/telescope.nvim",
			requires = { { "nvim-lua/plenary.nvim" } },
		})
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
		use("nvim-telescope/telescope-file-browser.nvim")

		-- Git
		use("tpope/vim-fugitive")
		use({
			"lewis6991/gitsigns.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
			},
		})

		-- Flutter
		use({ "akinsho/flutter-tools.nvim", requires = "nvim-lua/plenary.nvim" })
		use("f-person/pubspec-assist-nvim")
		-- Snippet
		use("RobertBrunhage/flutter-riverpod-snippets")

		-- Debug Adapter Protocol
		use("mfussenegger/nvim-dap")
		use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

		-- Preview
		-- Markdown
		use("ellisonleao/glow.nvim")
		use({ "iamcco/markdown-preview.nvim", ft = "markdown", run = "cd app && yarn install" })
		-- HTML
		use("turbio/bracey.vim")

		-- Todo
		use({
			"folke/todo-comments.nvim",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		-- Trouble
		use({
			"folke/trouble.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		})

		-- Symbol Outline
		use("simrat39/symbols-outline.nvim")

		-- Hop
		use({
			"phaazon/hop.nvim",
			branch = "v1", -- optional but strongly recommended
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		-- Vim Fetch
		use("wsdjeg/vim-fetch")

		-- Session Manager
		use("Shatur/neovim-session-manager")

		-- Startup time profiler
		use("dstein64/vim-startuptime")

		-- Fast Startup
		use("lewis6991/impatient.nvim")

		-- Colorizer
		use("norcalli/nvim-colorizer.lua")

		if packer_boostrap then
			require("packer").sync()
		end
	end,
})
