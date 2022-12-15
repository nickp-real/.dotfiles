-- Var
local keymap_utils = require("keymap_utils")
local nnoremap = keymap_utils.nnoremap
local inoremap = keymap_utils.inoremap
local vnoremap = keymap_utils.vnoremap
local xnoremap = keymap_utils.xnoremap
local nxnoremap = keymap_utils.nxnoremap

-- Spacebar to nothing
nnoremap("<Space>", "<Nop>")

-- Save
nnoremap("<C-s>", ":w<CR>")
inoremap("<C-s>", "<Esc>:w<Cr>a")

-- Visual indent
vnoremap(">", ">gv")
vnoremap("<", "<gv")

-- Better enter insert mode on blank line
nnoremap("i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil
      and vim.bo.filetype ~= "toggleterm"
      and vim.bo.filetype ~= "TelescopePrompt"
      and "cc"
    or "i"
end, { expr = true })

-- delete a character without yank into register
nnoremap("x", '"_x')
nnoremap("X", '"_X')
vnoremap("x", '"_x')
vnoremap("X", '"_X')

-- Don't yank on visual paste
vnoremap("p", '"_dP')

-- paste
xnoremap("<leader>p", '"_dP')

-- delete blank line without yank into register
local function smart_dd()
  if vim.api.nvim_get_current_line():match("^%s*$") then
    return '"_dd'
  end
  return "dd"
end

nnoremap("dd", smart_dd, { expr = true })

-- Delete buffer
nnoremap("<C-c>", ":Bdelete<cr>")
nnoremap("<C-q>", ":bd<cr>")

-- Increment/Decrement
nnoremap("+", "<C-a>")
nnoremap("-", "<C-x>")

-- Ctrl-W to Alt
nnoremap("<A-o>", "<C-w>o")
nnoremap("<A-w>", "<C-w>w")

-- Split
nnoremap("<leader>ss", ":split<cr><C-w>w")
nnoremap("<leader>sv", ":vsplit<cr><C-w>w")

-- Split resize
nnoremap("<A-Up>", ":resize +2<cr>")
nnoremap("<A-Down>", ":resize -2<cr>")
nnoremap("<A-Left>", ":vertical resize -2<cr>")
nnoremap("<A-Right>", ":vertical resize +2<cr>")

-- Tab
nnoremap("<leader>te", ":tabedit<cr>")
nnoremap("<leader>tq", ":tabclose<cr>")

-- Keep it center
nnoremap("n", "nzzzv")
nnoremap("N", "Nzzzv")

-- Toggle the split/join the code block
nnoremap("J", ":TSJToggle<cr>")

-- Undo break points
inoremap(",", ",<C-g>u")
inoremap(".", ".<C-g>u")
inoremap("!", "!<C-g>u")
inoremap("?", "?<C-g>u")

-- Moving text
nnoremap("<leader>j", ":m .+1<cr>==")
nnoremap("<leader>k", ":m .-2<cr>==")
inoremap("<C-j>", "<Esc>:m .+1<CR>==gi")
inoremap("<C-k>", "<Esc>:m .-2<CR>==gi")
vnoremap("J", ":m '>+1<CR>gv=gv")
vnoremap("K", ":m '<-2<CR>gv=gv")

-- Select All Text
nnoremap("<leader>a", ":keepjumps normal! ggVG<cr>")

-- Format Async on save
vim.cmd([[cabbrev wq execute "lua vim.lsp.buf.format()" <bar> wq]])

-- LSP
nnoremap("<space>e", vim.diagnostic.open_float)
nnoremap("[d", vim.diagnostic.goto_prev)
nnoremap("]d", vim.diagnostic.goto_next)
nnoremap("<space>q", vim.diagnostic.setloclist)

-- Coderunner
nnoremap("<leader>r", ":Run<cr>")
nnoremap("<leader>R", ":RunUpdate<cr>")

------------
-- Plugin --
------------

-- NeoTree
nnoremap("<C-n>", ":Neotree reveal toggle<cr>")

-- Toggle Terminal
vim.api.nvim_create_autocmd("TermOpen", {
  -- pattern = "term://*toggleterm#*",
  callback = function()
    local opts = { noremap = true, silent = true }
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
nnoremap("<Tab>", ":BufferLineCycleNext<CR>")
nnoremap("<S-Tab>", ":BufferLineCyclePrev<CR>")

-- Hop
nnoremap("s", ":HopChar1<cr>")
nnoremap("S", ":HopWord<cr>")

-- Hlslens
nxnoremap("*", [[<Plug>(asterisk-z*):lua require('hlslens').start()<CR>]])
nxnoremap("#", [[<Plug>(asterisk-z#):lua require('hlslens').start()<CR>]])
nxnoremap("g*", [[<Plug>(asterisk-gz*):lua require('hlslens').start()<CR>]])
nxnoremap("g#", [[<Plug>(asterisk-gz#):lua require('hlslens').start()<CR>]])

-- UFO
nnoremap("zR", ":lua require('ufo').openAllFolds()<cr>")
nnoremap("zM", ":lua require('ufo').closeAllFolds()<cr>")
-- nnoremap("zr", ":lua require('ufo').openFoldsExceptKinds()<cr>")
-- nnoremap("zm", ":lua require('ufo').closeFoldsWith(0)<cr>")

-- ISwap
nnoremap("<leader>sw", ":ISwap<cr>")

-- Telescope
nnoremap("<leader>ff", ":Telescope find_files<cr>")
nnoremap("<leader>fF", function()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files()
  else
    require("telescope.builtin").find_files()
  end
end)
nnoremap("<leader>fg", ":Telescope live_grep<cr>")
nnoremap("<leader>fb", ":Telescope buffers<cr>")
nnoremap("<leader>fh", ":Telescope help_tags<cr>")
nnoremap("<leader>fo", ":Telescope oldfiles<cr>")
nnoremap("<leader>fn", ":Telescope file_browser<cr>")
nnoremap("<leader>fN", ":Telescope file_browser path=%:p:h<cr>")
nnoremap("<leader>fk", ":Telescope keymaps<cr>")

-- Trouble
nnoremap("<leader>xx", ":TroubleToggle<cr>")
nnoremap("<leader>xw", ":TroubleToggle workspace_diagnostics<cr>")
nnoremap("<leader>xd", ":TroubleToggle document_diagnostics<cr>")
nnoremap("<leader>xq", ":TroubleToggle quickfix<cr>")
nnoremap("<leader>xl", ":TroubleToggle loclist<cr>")
nnoremap("<leader>xr", ":TroubleToggle lsp_references<cr>")
nnoremap("<leader>xt", ":TodoTrouble<cr>")

-- Symbols Outline
nnoremap("<leader>so", ":SymbolsOutline<cr>")

-- Session Manager
nnoremap("<leader>sl", ":SessionManager load_last_session<cr>")
nnoremap("<leader>sn", ":SessionManager load_session<cr>")

-- Git
nnoremap("<leader>gs", ":Neogit<cr>")
-- nnoremap("<leader>gh" , ":diffget //2<cr>")
-- nnoremap("<leader>gl" , ":diffget //3<cr>")

-- Diffview
nnoremap("<leader>ds", ":DiffviewOpen<cr>")
nnoremap("<leader>df", ":DiffviewFileHistory %<cr>")
nnoremap("<leader>dF", ":DiffviewFileHistory<cr>")

-- Neogen
nnoremap("<leader>nf", ":Neogen func<cr>")
nnoremap("<leader>nc", ":Neogen class<cr>")
nnoremap("<leader>nt", ":Neogen type<cr>")

-- Bufferline
nnoremap("<leader><Tab>", ":BufferLineMoveNext<CR>")
nnoremap("<leader><S-Tab>", ":BufferLineMovePrev<CR>")

-- SwapSplit
nnoremap("<leader>sp", ":SwapSplit<cr>")

-- LSP line
-- nnoremap("<Leader>l", ": lua require('lsp_lines').toggle<cr>")

-- Duck
local duck = require("duck")
nnoremap("<leader>dd", duck.hatch)
nnoremap("<leader>dk", duck.cook)

-- Dap
local dap = require("dap")
nnoremap("<F5>", dap.continue)
nnoremap("<F10>", dap.step_over)
nnoremap("<F11>", dap.step_into)
nnoremap("<F12>", dap.step_out)
nnoremap("<leader>b", dap.toggle_breakpoint)
nnoremap("<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>")
nnoremap("<leader>lp", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>")
nnoremap("<leader>dr", dap.repl.open)
