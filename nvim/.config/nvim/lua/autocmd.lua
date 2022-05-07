local exec_group = vim.api.nvim_create_augroup("ExecCode", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
	pattern = "python",
	callback = function()
		vim.schedule(function()
			vim.api.nvim_set_keymap(
				"n",
				"<leader>r",
				'<cmd>TermExec cmd="python %"<cr>',
				{ noremap = true, silent = true }
			)
		end)
	end,
	group = exec_group,
})

local yank = vim.api.nvim_create_augroup("yank", { clear = true })
vim.api.nvim_create_autocmd(
	"TextYankPost",
	{ pattern = "*", command = 'lua vim.highlight.on_yank({higroup="Visual", timeout=200})', group = yank }
)
