local M = {
  "goolord/alpha-nvim",
  event = "VimEnter",
}

function M.config()
  local function footer()
    local version = vim.version()
    local nvim_version_info = "   v" .. version.major .. "." .. version.minor .. "." .. version.patch
    return nvim_version_info
  end

  local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
      position = "center",
      text = txt,
      shortcut = sc,
      cursor = 5,
      width = 50,
      align_shortcut = "right",
      hl = "AlphaButtons",
      hl_shortcut = "AlphaShortcut",
    }

    if keybind then
      opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

    return {
      type = "button",
      val = txt,
      on_press = function()
        local key = vim.api.nvim_replace_termcodes(sc_, true, false, true) or ""
        vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
    }
  end

  local fn = vim.fn
  local marginTopPercent = 0.1
  local headerPadding = fn.max({ 2, fn.floor(fn.winheight(0) * marginTopPercent) })

  local options = {
    header = {
      type = "text",
      val = {
        [[      ___           ___           ___           ___                       ___     ]],
        [[     /\__\         /\  \         /\  \         /\__\          ___        /\__\    ]],
        [[    /::|  |       /::\  \       /::\  \       /:/  /         /\  \      /::|  |   ]],
        [[   /:|:|  |      /:/\:\  \     /:/\:\  \     /:/  /          \:\  \    /:|:|  |   ]],
        [[  /:/|:|  |__   /::\~\:\  \   /:/  \:\  \   /:/__/  ___      /::\__\  /:/|:|__|__ ]],
        [[ /:/ |:| /\__\ /:/\:\ \:\__\ /:/__/ \:\__\  |:|  | /\__\  __/:/\/__/ /:/ |::::\__\]],
        [[ \/__|:|/:/  / \:\~\:\ \/__/ \:\  \ /:/  /  |:|  |/:/  / /\/:/  /    \/__/~~/:/  /]],
        [[     |:/:/  /   \:\ \:\__\    \:\  /:/  /   |:|__/:/  /  \::/__/           /:/  / ]],
        [[     |::/  /     \:\ \/__/     \:\/:/  /     \::::/__/    \:\__\          /:/  /  ]],
        [[     /:/  /       \:\__\        \::/  /       ~~~~         \/__/         /:/  /   ]],
        [[     \/__/         \/__/         \/__/                                   \/__/    ]],
      },
      opts = {
        position = "center",
        hl = "AlphaHeader",
      },
    },

    buttons = {
      type = "group",
      val = {
        button("e", "  New File", "<cmd>ene<bar>startinsert<CR>"),
        button("SPC f f", "  Find File", "<cmd>Telescope find_files<CR>"),
        button("SPC f n", "  File Browser"),
        button("SPC f o", "  Recently Opened Files"),
        -- button("SPC f r", "  Frecency/MRU"),
        button("SPC f g", "  Find Word", "<cmd>Telescope live_grep<cr>"),
        button("SPC f m", "  Jump to Bookmarks"),
        button("SPC s l", "  Open Last Session"),
        button("v", "  Neovim Config", "<cmd>e ~/.config/nvim/init.lua<CR>"),
        -- button("p", "  Plugin Config", "<cmd>e ~/.config/nvim/after/plugin/<CR>"),
        -- button("t", "  Theme Config", "<cmd>e ~/.config/nvim/plugin/theme.lua<CR>"),
        button("q", "  Quit NVIM", "<cmd>qa<CR>"),
      },
      opts = {
        spacing = 1,
      },
    },
    headerPaddingTop = { type = "padding", val = headerPadding },
    headerPaddingBottom = { type = "padding", val = 2 },
    footer = {
      type = "text",
      val = footer(),
      opts = {
        position = "center",
        hl = "AlphaFooter",
      },
    },
  }

  require("alpha").setup({
    layout = {
      options.headerPaddingTop,
      options.header,
      options.headerPaddingBottom,
      options.buttons,
      options.headerPaddingBottom,
      options.footer,
    },
    opts = {},
  })
end

return M
