-- Var
local keymap_utils = require("utils.keymap_utils")
local nnoremap = keymap_utils.nnoremap
local inoremap = keymap_utils.inoremap
local innoremap = keymap_utils.inoremap
local vnoremap = keymap_utils.vnoremap
local nvnoremap = keymap_utils.nvnoremap
local xnoremap = keymap_utils.xnoremap

-- Visual indent
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- Better enter insert mode on blank line
nnoremap("i", function()
  local current_line = vim.api.nvim_get_current_line()
  return current_line:match("^%s*$")
      and string.match(current_line, "%g") == nil
      and vim.bo.filetype ~= "FTerm"
      and vim.bo.filetype ~= "TelescopePrompt"
      and "cc"
    or "i"
end, { expr = true })

-- delete a character without yank into register
nvnoremap("x", '"_x')
nvnoremap("X", '"_X')

-- Don't yank on visual paste
xnoremap("p", '"_dP')

-- paste
xnoremap("<leader>p", '"_dP')

-- Yank to system clipboard
nvnoremap("<leader>y", '"+y')
nnoremap("<leader>Y", '"+Y')

-- delete blank line without yank into register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then return '"_dd' end
  return "dd"
end

nnoremap("dd", smart_dd, { expr = true })
-- delete without yank
nvnoremap("<leader>d", '"_d')

-- Delete buffer
nnoremap("<leader>0", "<cmd>bd|e#|bd#<cr>", { desc = "Close all buffers except current" })

-- Increment/Decrement
nnoremap("+", "<C-a>")
nnoremap("-", "<C-x>")

-- next block
nnoremap("<down>", "}")
nnoremap("<up>", "{")

-- Ctrl-W to Alt
nnoremap("<A-o>", "<C-w>o")
nnoremap("<A-w>", "<C-w>w")

-- Split
nnoremap("\\", ":split<cr><C-w>w")
nnoremap("|", ":vsplit<cr><C-w>w")

-- Tab
nnoremap("<leader>te", ":tabedit<cr>", { desc = "New tab" })
nnoremap("<leader>tq", ":tabclose<cr>", { desc = "Close tab" })

-- Undo break points
inoremap(",", ",<C-g>u")
inoremap(".", ".<C-g>u")
inoremap("!", "!<C-g>u")
inoremap("?", "?<C-g>u")

-- Moving text
nnoremap("<leader>j", ":m .+1<cr>==")
nnoremap("<leader>k", ":m .-2<cr>==")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Better up down
nnoremap("j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
nnoremap("k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Select All Text
nnoremap("<leader>sa", ":keepjumps normal! ggVG<cr>")

-- No Q
nnoremap("Q", "<nop>")

-- Quit
nnoremap("<leader>Q", "<cmd>qa<cr>", { desc = "Quit all" })
nnoremap("<C-q>", "<cmd>q<cr>", { desc = "Quit" })

-- Subtitute current word
nnoremap("<leader>ss", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { silent = false })

-- chmod in vim
-- nnoremap("<leader>x", ":!chmod +x %<cr>")

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
nnoremap(
  "<esc>",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" }
)

-- Clear search with <esc>
innoremap("<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Keep screen center
nnoremap("<C-u>", "<C-u>zz", { desc = "Scroll up and center" })
nnoremap("<C-d>", "<C-d>zz", { desc = "Scroll down and center" })
nnoremap("n", "nzzzv", { desc = "Go to next search and center" })
nnoremap("N", "Nzzzv", { desc = "Go to previous search and center" })

-- Coderunner
nnoremap("<leader>r", vim.cmd.Run)
nnoremap("<leader>R", vim.cmd.RunUpdate)

-- LSP line
-- nnoremap("<Leader>l", "<cmd> lua require('lsp_lines').toggle<cr>")

-- LSP
local function diagnostic_goto(next, severity)
  local go = vim.diagnostic.jump
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function() go({ count = next == true and 1 or -1, severity = severity, float = false }) end
end
nnoremap("]e", diagnostic_goto(true, "ERROR"), { desc = "Go to next [E]rror message" })
nnoremap("[e", diagnostic_goto(false, "ERROR"), { desc = "Go to previous [E]rror message" })
nnoremap("]w", diagnostic_goto(true, "WARN"), { desc = "Go to next [W]arning message" })
nnoremap("[w", diagnostic_goto(false, "WARN"), { desc = "Go to previous [W]arning message" })
-- nnoremap("]d", diagnostic_goto(true), { desc = "Go to next [D]iagnostic message" })
-- nnoremap("[d", diagnostic_goto(false), { desc = "Go to previous [D]iagnostic message" })
-- nnoremap("<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
nnoremap("<C-q>", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uicfix list" })
