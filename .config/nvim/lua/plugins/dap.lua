local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", config = function() require("dapui").setup() end}
  }
}

function M.init()
  local nnoremap = require("keymap_utils").nnoremap
  nnoremap( "<leader>db", function()
    require("dap").toggle_breakpoint()
  end, { desc = "Toggle Breakpoint" })

  nnoremap( "<leader>dc", function()
    require("dap").continue()
  end, { desc = "Continue" })

  nnoremap( "<leader>do", function()
    require("dap").step_over()
  end, { desc = "Step Over" })

  nnoremap( "<leader>di", function()
    require("dap").step_into()
  end, { desc = "Step Into" })

  nnoremap( "<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Widgets" })

  nnoremap( "<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "Repl" })

  nnoremap( "<leader>du", function()
    require("dapui").toggle({})
  end, { desc = "Dap UI" })
end

function M.config()
  local dap = require("dap")
  local dapui = require("dapui")

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

return M
