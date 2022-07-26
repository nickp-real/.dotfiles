-- Var
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

local function nkeymap(key, map)
  keymap("n", key, map, opts)
end

local function ikeymap(key, map)
  keymap("i", key, map, opts)
end

local function vkeymap(key, map)
  keymap("v", key, map, opts)
end

-- Spacebar to nothing
keymap("n", "<Space>", "<Nop>", {})

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
-- nkeymap("x", "_x")

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

-- Ctrl-W to Alt
nkeymap("<A-h>", "<C-w>h")
nkeymap("<A-j>", "<C-w>j")
nkeymap("<A-k>", "<C-w>k")
nkeymap("<A-l>", "<C-w>l")
nkeymap("<A-o>", "<C-w>o")

-- Split resize
nkeymap("<A-Up>", ":resize +2<cr>")
nkeymap("<A-Down>", ":resize -2<cr>")
nkeymap("<A-Left>", ":vertical resize -2<cr>")
nkeymap("<A-Right>", ":vertical resize +2<cr>")

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
nkeymap("<leader>j", ":m .+1<cr>==")
nkeymap("<leader>k", ":m .-2<cr>==")

-- Select all text
nkeymap("<leader>a", "<cmd>keepjumps normal! ggVG<cr>")

-- Coderunner
nkeymap("<leader>r", "<cmd>Run<cr>")
nkeymap("<leader><S-r>", "<cmd>RunUpdate<cr>")

-- Format Async on save
vim.cmd([[cabbrev wq execute "Format sync" <bar> wq]])

-- Clear highlight
nkeymap("<c-h>", "<cmd>nohlsearch<cr>")

-- LSP
nkeymap("gw", ":lua vim.lsp.buf.document_symbol()<cr>")
nkeymap("gw", ":lua vim.lsp.buf.workspace_symbol()<cr>")

-- Telescope
nkeymap("<leader>ff", "<cmd>Telescope find_files<cr>")
nkeymap("<leader>fg", "<cmd>Telescope live_grep<cr>")
nkeymap("<leader>fb", "<cmd>Telescope buffers<cr>")
nkeymap("<leader>fh", "<cmd>Telescope help_tags<cr>")
nkeymap("<leader>fo", "<cmd>Telescope oldfiles<cr>")
nkeymap("<leader>fn", "<cmd>Telescope file_browser<cr>")
nkeymap("<leader>fN", "<cmd>Telescope file_browser path=%:p:h<cr>")

-- NvimTree
nkeymap("<C-n>", "<cmd>NvimTreeToggle<cr>")
nkeymap("<leader>nr", "<cmd>NvimTreeRefresh<cr>")

-- Toggle Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "term://*toggleterm#*",
  callback = function()
    vim.schedule(function()
      vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
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
nkeymap("<leader><Tab>", "<cmd>BufferLineMoveNext<CR>")
nkeymap("<leader><S-Tab>", "<cmd>BufferLineMovePrev<CR>")

-- Trouble
nkeymap("<leader>xx", "<cmd>TroubleToggle<cr>")
nkeymap("<leader>xw", "<cmd>TroubleToggle workspace_diagnostics<cr>")
nkeymap("<leader>xd", "<cmd>TroubleToggle document_diagnostics<cr>")
nkeymap("<leader>xq", "<cmd>TroubleToggle quickfix<cr>")
nkeymap("<leader>xl", "<cmd>TroubleToggle loclist<cr>")
nkeymap("<leader>xr", "<cmd>TroubleToggle lsp_references<cr>")

-- Todo
nkeymap("<leader>xt", "<cmd>TodoTrouble<cr>")

-- Symbol Outline
nkeymap("<leader>o", "<cmd>SymbolsOutline<cr>")

-- Hop
nkeymap("s", "<cmd>HopChar2<cr>")
nkeymap("S", "<cmd>HopWord<cr>")

-- Session Manager
nkeymap("<leader>sl", "<cmd>SessionManager load_last_session<cr>")
nkeymap("<leader>so", "<cmd>SessionManager load_session<cr>")

-- Git
nkeymap("<leader>gs", "<cmd>G<cr>")
nkeymap("<leader>gh", "<cmd>diffget //2<cr>")
nkeymap("<leader>gl", "<cmd>diffget //3<cr>")

-- Neogen
nkeymap("<leader>nf", "<cmd>Neogen func<cr>")
nkeymap("<leader>nc", "<cmd>Neogen class<cr>")
nkeymap("<leader>nt", "<cmd>Neogen type<cr>")

-- Dial
nkeymap("<C-a>", require("dial.map").inc_normal())
nkeymap("<C-x>", require("dial.map").dec_normal())
vkeymap("<C-a>", require("dial.map").inc_visual())
vkeymap("<C-x>", require("dial.map").dec_visual())
vkeymap("g<C-a>", require("dial.map").inc_gvisual())
vkeymap("g<C-x>", require("dial.map").dec_gvisual())
