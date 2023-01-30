local M = {
  "mfussenegger/nvim-dap",
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      config = function()
        require("dapui").setup()
      end,
    },
  },
}

M.keys = {
  { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
  { "<leader>dc", '<cmd>lua require("dap").continue()<cr>', desc = "Continue" },
  { "<leader>do", '<cmd>lua require("dap").step_over()<cr>', desc = "Step Over" },
  { "<leader>di", '<cmd>lua require("dap").step_into()<cr>', desc = "Step Into" },
  { "<leader>dw", '<cmd>lua require("dap.ui.widgets").hover()<cr>', desc = "Widgets" },
  { "<leader>dr", '<cmd>lua require("dap").repl.open()<cr>', desc = "Repl" },
  { "<leader>du", '<cmd>lua require("dapui").toggle({})<cr>', desc = "Dap UI" },
}

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
