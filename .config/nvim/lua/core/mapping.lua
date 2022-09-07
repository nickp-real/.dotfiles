-- Var
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
local wk = require("which-key")

local function nkeymap(key, map)
  keymap("n", key, map, opts)
end

local function ikeymap(key, map)
  keymap("i", key, map, opts)
end

local function vkeymap(key, map)
  keymap("v", key, map, opts)
end

local function xkeymap(key, map)
  keymap("x", key, map, opts)
end

-- Spacebar to nothing
keymap("n", "<Space>", "<Nop>", { noremap = true })

-- Leader
vim.g.mapleader = " "

-- Save
keymap("n", "<C-s>", ":w<CR>", { silent = true })
keymap("i", "<C-s>", "<Esc>:w<CR>a", { silent = true })

-- Visual indent
vkeymap(">", ">gv")
vkeymap("<", "<gv")

-- Better enter insert mode on blank line
vim.keymap.set("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil
      and vim.bo.filetype ~= "toggleterm"
      and vim.bo.filetype ~= "TelescopePrompt"
      and "cc"
    or "i"
end, { expr = true, noremap = true })

-- delete a character without yank into register
nkeymap("x", '"_x')
nkeymap("X", '"_X')
vkeymap("x", '"_x')
vkeymap("X", '"_X')

-- Don't yank on visual paste
vkeymap("p", '"_dP')

-- delete blank line without yank into register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end

vim.keymap.set("n", "dd", smart_dd, { noremap = true, expr = true })

-- Delete buffer
nkeymap("<C-c>", ":Bdelete<cr>")
nkeymap("<C-q>", ":bd<cr>")

-- Increment/Decrement
nkeymap("+", "<C-a>")
nkeymap("-", "<C-x>")

-- Ctrl-W to Alt
nkeymap("<A-h>", "<C-w>h")
nkeymap("<A-j>", "<C-w>j")
nkeymap("<A-k>", "<C-w>k")
nkeymap("<A-l>", "<C-w>l")
nkeymap("<A-o>", "<C-w>o")
nkeymap("<A-w>", "<C-w>w")

-- Split resize
nkeymap("<A-Up>", ":resize +2<cr>")
nkeymap("<A-Down>", ":resize -2<cr>")
nkeymap("<A-Left>", ":vertical resize -2<cr>")
nkeymap("<A-Right>", ":vertical resize +2<cr>")

-- Split
nkeymap("<leader>ss", ":split<cr><C-w>w")
nkeymap("<leader>sv", ":vsplit<cr><C-w>w")

-- Keeping it center
nkeymap("n", "nzzzv")
nkeymap("N", "Nzzzv")
nkeymap("J", "mzJ`z")

-- Undo break points
ikeymap(",", ",<C-g>u")
ikeymap(".", ".<C-g>u")
ikeymap("!", "!<C-g>u")
ikeymap("?", "?<C-g>u")

-- Moving text
vkeymap("J", ":m '>+1<CR>gv=gv")
vkeymap("K", ":m '<-2<CR>gv=gv")
ikeymap("<C-j>", "<Esc>:m .+1<CR>==gi")
ikeymap("<C-k>", "<Esc>:m .-2<CR>==gi")

-- Format Async on save
vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- Clear highlight
nkeymap("<c-h>", "<cmd>nohlsearch<cr>")

-- LSP
nkeymap("gw", ":lua vim.lsp.buf.document_symbol()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")

-- NvimTree
nkeymap("<C-n>", "<cmd>NvimTreeToggle<cr>")
nkeymap("<leader>nr", "<cmd>NvimTreeRefresh<cr>")

-- Toggle Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  -- pattern = "term://*toggleterm#*",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_buf_set_keymap(0, "t", "<leader><esc>", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "jk", [[<C-\><C-n>]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<A-h>", [[<C-\><C-n><C-W>h]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<A-j>", [[<C-\><C-n><C-W>j]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<A-k>", [[<C-\><C-n><C-W>k]], opts)
      vim.api.nvim_buf_set_keymap(0, "t", "<A-l>", [[<C-\><C-n><C-W>l]], opts)
    end)
  end,
})

-- Buffer line
nkeymap("<Tab>", "<cmd>BufferLineCycleNext<CR>")
nkeymap("<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

-- Hop
nkeymap("s", "<cmd>HopChar2<cr>")
nkeymap("S", "<cmd>HopWord<cr>")
vim.api.nvim_set_keymap(
  "",
  "f",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "",
  "F",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "",
  "t",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })<cr>",
  {}
)
vim.api.nvim_set_keymap(
  "",
  "T",
  "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })<cr>",
  {}
)

-- Hlslens
nkeymap("*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]])
nkeymap("#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]])
nkeymap("g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]])
nkeymap("g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]])

xkeymap("*", [[<Plug>(asterisk-z*)<Cmd>lua require('hlslens').start()<CR>]])
xkeymap("#", [[<Plug>(asterisk-z#)<Cmd>lua require('hlslens').start()<CR>]])
xkeymap("g*", [[<Plug>(asterisk-gz*)<Cmd>lua require('hlslens').start()<CR>]])
xkeymap("g#", [[<Plug>(asterisk-gz#)<Cmd>lua require('hlslens').start()<CR>]])

-- UFO
nkeymap("zR", ":lua require('ufo').openAllFolds()<cr>")
nkeymap("zM", ":lua require('ufo').closeAllFolds()<cr>")
-- nkeymap("zr", ":lua require('ufo').openFoldsExceptKinds()<cr>")
-- nkeymap("zm", ":lua require('ufo').closeFoldsWith(0)<cr>")

-- Dial
nkeymap("<C-a>", require("dial.map").inc_normal())
nkeymap("<C-x>", require("dial.map").dec_normal())
vkeymap("<C-a>", require("dial.map").inc_visual())
vkeymap("<C-x>", require("dial.map").dec_visual())
vkeymap("g<C-a>", require("dial.map").inc_gvisual())
vkeymap("g<C-x>", require("dial.map").dec_gvisual())

-- ISwap
nkeymap("<leader>sw", "<cmd>ISwap<cr>")

local leader_mapping = {
  ["<leader>"] = {
    -- Telescope
    f = {
      name = "Telescope",
      f = { "<cmd>Telescope find_files<cr>", "Find File" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help Tags" },
      o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
      n = { "<cmd>Telescope file_browser<cr>", "Browse Current Working Dir" },
      N = { "<cmd>Telescope file_browser path=%:p:h<cr>", "Browse Current Dir" },
    },

    -- Trouble
    x = {
      name = "Trouble",
      x = { "<cmd>TroubleToggle<cr>", "Toggle" },
      w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Workspace Diagnostics" },
      d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Document Diagnostics" },
      q = { "<cmd>TroubleToggle quickfix<cr>", "Quickfix" },
      l = { "<cmd>TroubleToggle loclist<cr>", "Loclist" },
      r = { "<cmd>TroubleToggle lsp_references<cr>", "LSP References" },
      t = { "<cmd>TodoTrouble<cr>", "Todo" },
    },

    -- Symbols Outline
    o = { "<cmd>SymbolsOutline<cr>", "Symbols Outline" },

    -- Session Manager
    s = {
      name = "Session Manager",
      l = { "<cmd>SessionManager load_last_session<cr>", "Load Last Session" },
      o = { "<cmd>SessionManager load_session<cr>", "Load Session" },
    },

    -- Git
    g = {
      name = "Git",
      s = { "<cmd>Neogit<cr>", "Show" },
      h = { "<cmd>diffget //2<cr>", "Diff Get Left" },
      l = { "<cmd>diffget //3<cr>", "Diff Get Right" },
      d = {
        name = "File History Diff",
        f = { "<cmd>DiffviewFileHistory %<cr>", "View Current File Diff" },
        F = { "<cmd>DiffviewFileHistory<cr>", "View Current Branch Diff" },
      },
      D = { "<cmd>DiffviewOpen<cr>", "View Diff" },
    },

    -- Neogen
    n = {
      name = "Neogen",
      f = { "<cmd>Neogen func<cr>", "Function" },
      c = { "<cmd>Neogen class<cr>", "Class" },
      t = { "<cmd>Neogen type<cr>", "Type" },
    },

    -- Bufferline
    ["<Tab>"] = { "<cmd>BufferLineMoveNext<CR>", "Buffer Tab Move Next" },
    ["<S-Tab>"] = { "<cmd>BufferLineMovePrev<CR>", "Buffer Tab Move Prev" },

    -- Tab
    t = {
      e = { ":tabedit<cr>", "New Tab" },
      q = { ":tabclose<cr>", "Close Tab" },
    },

    -- Moving Text
    j = { ":m .+1<cr>==", "Up" },
    k = { ":m .-2<cr>==", "Down" },

    -- Select All Text
    a = { "<cmd>keepjumps normal! ggVG<cr>", "Select All Text" },

    -- Coderunner
    r = { "<cmd>Run<cr>", "Run Code" },
    R = { "<cmd>RunUpdate<cr>", "Update Run Code Command" },
  },
}

wk.register(leader_mapping)

-- LSP line
-- nkeymap("<Leader>l", "<cmd> lua require('lsp_lines').toggle<cr>")
