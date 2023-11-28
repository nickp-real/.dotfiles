local utils = require("heirline.utils")
local picker = require("plugins.heirline.tabline.picker")

-- this is the default function used to retrieve buffers
local get_bufs = function()
  return vim.tbl_filter(function(bufnr)
    return vim.api.nvim_buf_get_option(bufnr, "buflisted")
  end, vim.api.nvim_list_bufs())
end

-- initialize the buflist cache
local buflist_cache = {}

local bufferline_group = vim.api.nvim_create_augroup("Buffer Line", { clear = true })

-- setup an autocmd that updates the buflist_cache every time that buffers are added/removed
vim.api.nvim_create_autocmd({ "VimEnter", "UIEnter", "BufAdd", "BufDelete" }, {
  group = bufferline_group,
  callback = function()
    vim.schedule(function()
      local buffers = get_bufs()
      for i, v in ipairs(buffers) do
        buflist_cache[i] = v
      end
      for i = #buffers + 1, #buflist_cache do
        buflist_cache[i] = nil
      end

      -- check how many buffers we have and set showtabline accordingly
      if #buflist_cache > 1 then
        vim.o.showtabline = 2 -- always
      else
        vim.o.showtabline = 1 -- only when #tabpages > 1
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  desc = "Update buffers when deleting buffers",
  group = bufferline_group,
  callback = function(args)
    local buffers = get_bufs()
    local deletedBufnr = args.buf
    local nextBufnr = -1
    for _, v in ipairs(buffers) do
      if v > deletedBufnr and nextBufnr ~= -1 then
        break
      end
      if v ~= deletedBufnr then
        nextBufnr = v
      end
    end
    vim.api.nvim_win_set_buf(0, nextBufnr)
    vim.cmd.redrawtabline()
  end,
})

vim.cmd([[au FileType * if index(['wipe', 'delete'], &bufhidden) >= 0 | set nobuflisted | endif]])

-- and here we go
return {
  require("plugins.heirline.tabline.taboffset"),
  utils.make_buflist(
    require("plugins.heirline.tabline.block"),
    { provider = "", hl = { fg = "gray" } }, -- left truncation, optional (defaults to "<")
    { provider = "", hl = { fg = "gray" } }, -- right trunctation, also optional (defaults to ...... yep, ">")
    -- by the way, open a lot of buffers and try clicking them ;)
    function()
      return buflist_cache
    end,
    -- no cache, as we're handling everything ourselves
    false
  ),
  require("plugins.heirline.tabline.tabpage"),
}
