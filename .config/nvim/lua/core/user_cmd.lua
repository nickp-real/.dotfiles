local user_cmd = function(cmd, expr, options)
  options = options or {}
  vim.api.nvim_create_user_command(cmd, expr, options)
end

user_cmd("PrettyJson", ":%!jq '.'")
