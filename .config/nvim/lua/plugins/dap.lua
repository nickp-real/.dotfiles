local js_based_languages =
  { "typescript", "javascript", "typescriptreact", "javascriptreact", "vue", "svelte", "astro" }

return {
  -- Debug Adaptor Protocol
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        keys = {
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = { "n", "v" } },
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI" },
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup()

          dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open({ reset = true }) end
          dap.listeners.before.event_terminated["dapui_config"] = dapui.close
          dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
      },
      { "theHamsta/nvim-dap-virtual-text", config = true },
      { "Joakker/lua-json5", run = "./install.sh" },

      -- JS debugger
      {
        "microsoft/vscode-js-debug",
        version = "1.*",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      },
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = vim.fn.resolve(vim.fn.stdpath("data") .. "/lazy/vscode-js-debug"),
          adapters = { "chrome", "pwa-node", "pwa-chrome", "pwa-msedge", "pwa-extensionHost", "node-terminal", "node" },
        },
      },
    },
    keys = {
      {
        "<leader>dB",
        function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end,
        desc = "Breakpoint Condition",
      },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      {
        "<leader>dc",
        function()
          if vim.fn.filereadable(".vscode/launch.json") then
            local dap_vscode = require("dap.ext.vscode")
            dap_vscode.load_launchjs(nil, {
              ["pwa-node"] = js_based_languages,
              ["node"] = js_based_languages,
              ["chrome"] = js_based_languages,
              ["pwa-chrome"] = js_based_languages,
            })
          end
          require("dap").continue()
        end,
        desc = "Continue",
      },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>d", function() require("dap").step_over() end, desc = "Step ver" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle Repl" },
    },
    config = function()
      local dap = require("dap")

      for _, language in ipairs(js_based_languages) do
        if not dap.configurations[language] then
          dap.configurations[language] = {
            -- Debug single nodejs file
            {
              type = "pwa-node",
              request = "launch",
              name = "Launch file",
              program = "${file}",
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Debug nodejs processes
            {
              type = "pwa-node",
              request = "attach",
              name = "Attach",
              processId = require("dap.utils").pick_process,
              cwd = "${workspaceFolder}",
              sourceMaps = true,
            },
            -- Debug web application (clietn side)
            {
              type = "pwa-chrome",
              request = "launch",
              name = "Launch & Debug Chrome",
              url = function()
                local co = coroutine.running()
                return coroutine.create(function()
                  vim.ui.input({
                    prompt = "Enter URL: ",
                    default = "http://localhost:3000",
                    function(url)
                      if url == nil or url == "" then
                        return
                      else
                        coroutine.resume(co, url)
                      end
                    end,
                  })
                end)
              end,
              webRoot = "${workspaceFolder}",
              skipFiles = { "<node_internals>/**/*.js" },
              protocol = "inspector",
              sourceMaps = true,
              userDataDir = false,
            },
            -- Divider for the launch json derived configs
            {
              name = "----- ** launch.json configs ** -----",
              type = "",
              request = "launch",
            },
            -- Next.js Server-Side
            {
              name = "Next.js: debug server-side",
              type = "pwa-node",
              request = "launch",
              cwd = "${workspaceFolder}",
              runtimeExecutable = "npm",
              runtimeArgs = { "run-script", "dev" },
              sourceMaps = true,
            },
            -- Next.js Client-Side
            {
              name = "Next.js: debug client-side",
              type = "pwa-chrome",
              request = "launch",
              url = "http://localhost:3000",
              sourceMaps = true,
            },
          }
        end
      end
    end,
  },
}
