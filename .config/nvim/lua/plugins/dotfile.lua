local xdg_config = vim.env.XDG_CONFIG_HOME or vim.env.HOME .. "/.config"

local function have(path) return vim.loop.fs_stat(xdg_config .. "/" .. path) ~= nil end

return {
  {
    "luckasRanarison/tree-sitter-hypr",
    enabled = function() return have("hypr") end,
    event = "BufRead */hypr/*.conf",
    build = ":TSUpdate hypr",
    config = function()
      -- Fix ft detection for hyprland
      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hypr" },
      })
      require("nvim-treesitter.parsers").get_parser_configs().hypr = {
        install_info = {
          url = "https://github.com/luckasRanarison/tree-sitter-hypr",
          files = { "src/parser.c" },
          branch = "master",
        },
        filetype = "hypr",
      }
    end,
  },
}
