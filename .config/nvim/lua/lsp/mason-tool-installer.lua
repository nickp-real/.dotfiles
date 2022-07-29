local status_ok, mason_tool_installer = pcall(require, "mason-tool-installer")
if not status_ok then
  return
end

mason_tool_installer.setup({

  -- a list of all tools you want to ensure are installed upon
  -- start; they should be the names Mason uses for each tool
  ensure_installed = {
    ---------------
    -- Formatter --
    ---------------
    "golines",
    "stylua",
    "black",
    "prettierd",

    ------------
    -- Linter --
    ------------
    "eslint_d",
  },

  -- if set to true this will check each tool for updates. If updates
  -- are available the tool will be updated.
  -- Default: false
  auto_update = false,

  -- automatically install / update on startup. If set to false nothing
  -- will happen on startup. You can use `:MasonToolsUpdate` to install
  -- tools and check for updates.
  -- Default: true
  run_on_start = true,

  -- set a delay (in ms) before the installation starts. This is only
  -- effective if run_on_start is set to true.
  -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
  -- Default: 0
  start_delay = 0, -- 3 second delay
})
