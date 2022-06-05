local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
	packer_boostrap = fn.system({
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
		-- Packer
		use({ "wbthomason/packer.nvim" })

		-- Load first
		use("lewis6991/impatient.nvim")
		use("nathom/filetype.nvim")
		use("nvim-lua/plenary.nvim")
		use("nvim-lua/popup.nvim")
		use({
			"kyazdani42/nvim-web-devicons",
		})
		use({
			"goolord/alpha-nvim",
			config = function()
				require("plugins.alpha")
			end,
		})

		-- Discord Presence
		use({ "andweeb/presence.nvim", event = "BufRead" })

		-- Theme, Statusbar, Bufferbar
		use({
			"ful1e5/onedark.nvim",
			config = function()
				require("plugins.onedark")
			end,
		})

		use({
			"akinsho/bufferline.nvim",
			requires = "kyazdani42/nvim-web-devicons",
			after = "onedark.nvim",
			config = function()
				require("plugins.bufferline")
			end,
		})

		use({
			{
				"nvim-lualine/lualine.nvim",
				requires = { "kyazdani42/nvim-web-devicons", opt = true },
				after = "onedark.nvim",
				event = "BufEnter",
				config = function()
					require("plugins.lualine")
				end,
			},
			-- LSP progress indicator
			{
				"j-hui/fidget.nvim",
				after = "lualine.nvim",
				config = function()
					require("fidget").setup({})
				end,
			},
		})

		-- Treesitter
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
					vim.g.matchup_matchparen_offscreen = { method = "popup", border = 1 }
				end,
			},
			{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
		})

		use({
			"m-demare/hlargs.nvim",
			after = "nvim-treesitter",
			config = function()
				require("hlargs").setup({
					color = "#e59b4e",
				})
			end,
		})

		-- Log Highlight
		use({ "MTDL9/vim-log-highlighting", event = "BufRead", ft = "log" })

		-- UI
		use({
			"lukas-reineke/indent-blankline.nvim",
			event = "BufRead",
			config = function()
				require("plugins.indent-blankline")
			end,
		})

		use({
			"norcalli/nvim-colorizer.lua",
			event = "CursorHold",
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

		-- Navigation
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
				requires = { { "nvim-lua/plenary.nvim" } },
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
		})

		use({
			"phaazon/hop.nvim",
			branch = "v1", -- optional but strongly recommended
			event = "BufRead",
			config = function()
				-- you can configure Hop the way you like here; see :h hop-config
				require("hop").setup({ keys = "etovxqpdygfblzhckisuran" })
			end,
		})

		use({
			"karb94/neoscroll.nvim",
			event = "BufEnter",
			config = function()
				require("plugins.neoscroll")
			end,
		})

		-- Editing
		use({
			"numToStr/Comment.nvim",
			event = "BufRead",
			config = function()
				require("plugins.comment")
			end,
		})

		use({
			"abecodes/tabout.nvim",
			event = "BufRead",
			after = "nvim-treesitter",
			config = function()
				require("tabout").setup()
			end,
		})

		use({
			"ur4ltz/surround.nvim",
			event = "BufRead",
			config = function()
				require("surround").setup({ mappings_style = "surround" })
			end,
		})

		use({
			"wellle/targets.vim",
			event = "BufRead",
		})

		-- Terminal
		use({
			"akinsho/toggleterm.nvim",
			event = "CursorHold",
			config = function()
				require("plugins.toggleterm")
			end,
		})

		-- LSP
		use({
			{
				"williamboman/nvim-lsp-installer",
				config = function()
					require("nvim-lsp-installer").setup()
				end,
			},
			{
				"neovim/nvim-lspconfig",
				requires = "hrsh7th/cmp-nvim-lsp",
				event = "BufRead",
				config = function()
					require("lsp.lspconfigs")
				end,
			},
			{
				"jose-elias-alvarez/null-ls.nvim",
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
				event = "BufRead",
				requires = "nvim-lua/plenary.nvim",
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
					require("pubspec-assist").setup()
				end,
			},
			{ "RobertBrunhage/flutter-riverpod-snippets", ft = { "flutter", "dart" }, after = "nvim-cmp" },
		})

		-- LSP Addon
		use({
			"stevearc/dressing.nvim",
			config = function()
				require("plugins.dressing")
			end,
		})

		use({
			"folke/trouble.nvim",
			event = "CursorHold",
			requires = "kyazdani42/nvim-web-devicons",
			config = function()
				require("trouble").setup()
			end,
		})
		-- use("mfussenegger/nvim-lint")

		-- Completion
		use({
			{
				"hrsh7th/nvim-cmp",
				event = { "InsertEnter", "CmdLineEnter" },
				config = function()
					require("plugins.completion")
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
						config = function()
							require("neogen").setup({
								snippet_engine = "luasnip",
							})
						end,
						requires = "nvim-treesitter/nvim-treesitter",
					},
				},
			},
			{ "hrsh7th/cmp-nvim-lua", after = "nvim-cmp" },
			{ "hrsh7th/cmp-buffer", after = "nvim-cmp" },
			{ "hrsh7th/cmp-path", after = "nvim-cmp" },
			{ "hrsh7th/cmp-cmdline", after = "nvim-cmp" },
			{ "lukas-reineke/cmp-rg", after = "nvim-cmp" },
			{ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp" },
			{ "saadparwaiz1/cmp_luasnip", after = "nvim-cmp" },
		})

		use({
			"windwp/nvim-autopairs",
			after = { "nvim-treesitter", "nvim-cmp" },
			config = function()
				require("plugins.autopairs")
			end,
		})

		-- Git
		use({ "tpope/vim-fugitive", event = "CursorHold" })

		-- Debug Adapter Protocol
		use({
			"rcarriga/nvim-dap-ui",
			requires = {
				{
					"mfussenegger/nvim-dap",
					config = function()
						require("plugins.dap")
					end,
				},
			},
		})

		-- Preview
		-- Markdown
		use({ "ellisonleao/glow.nvim", ft = "markdown" })
		use({
			"iamcco/markdown-preview.nvim",
			ft = "markdown",
			run = "cd app && yarn install",
			cmd = "MarkdownPreview",
		})
		-- HTML
		use({
			"turbio/bracey.vim",
			ft = { "html", "css", "javascript" },
			config = function()
				vim.g.bracey_refresh_on_save = 1
			end,
		})

		-- General
		use({
			"folke/todo-comments.nvim",
			event = "BufRead",
			requires = "nvim-lua/plenary.nvim",
			config = function()
				require("todo-comments").setup()
			end,
		})

		use({
			"simrat39/symbols-outline.nvim",
			event = "CursorHold",
			config = function()
				require("plugins.symbol-outline")
			end,
		})

		use({
			"Shatur/neovim-session-manager",
			event = "BufEnter",
			config = function()
				require("plugins.session-manager")
			end,
		})

		use("dstein64/vim-startuptime")
		use("wsdjeg/vim-fetch")
		use("famiu/bufdelete.nvim")
		use({
			"kwkarlwang/bufresize.nvim",
			config = function()
				require("bufresize").setup()
			end,
		})

		if packer_boostrap then
			require("packer").sync()
		end
	end,
})
