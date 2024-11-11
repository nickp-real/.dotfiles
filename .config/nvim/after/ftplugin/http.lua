-- Execute request
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<CR>",
  function() require("kulala").run() end,
  { noremap = true, silent = true, desc = "Execute the request" }
)

-- Jump between request
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "[",
  function() require("kulala").jump_prev() end,
  { noremap = true, silent = true, desc = "Jump to the previous request" }
)
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "]",
  function() require("kulala").jump_next() end,
  { noremap = true, silent = true, desc = "Jump to the next request" }
)

-- Inspect the current request
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>i",
  function() require("kulala").inspect() end,
  { noremap = true, silent = true, desc = "Inspect the current request" }
)

-- Toggle body and headers
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>t",
  function() require("kulala").toggle_view() end,
  { noremap = true, silent = true, desc = "Toggle between body and headers" }
)

-- Copy as curl
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>co",
  function() require("kulala").copy() end,
  { noremap = true, silent = true, desc = "Copy the current request as a curl command" }
)

-- Insert from curl
vim.api.nvim_buf_set_keymap(
  0,
  "n",
  "<leader>ci",
  function() require("kulala").from_curl() end,
  { noremap = true, silent = true, desc = "Paste curl from clipboard as http request" }
)
