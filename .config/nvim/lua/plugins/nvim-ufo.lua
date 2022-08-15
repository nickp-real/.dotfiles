local status_ok, ufo = pcall(require, "ufo")
if not status_ok then
  return
end

local handler = function(virtText, lnum, endLnum, width, truncate, ctx)
  local newVirtText = {}
  local end_virt_text = ctx.end_virt_text
  local suffix = ("  %d "):format(endLnum - lnum)
  local padding = ""

  local sufWidth = vim.fn.strdisplaywidth(suffix)
  local targetWidth = width - sufWidth
  local curWidth = 0
  for _, chunk in ipairs(virtText) do
    local chunkText = chunk[1]
    local chunkWidth = vim.fn.strdisplaywidth(chunkText)
    if targetWidth > curWidth + chunkWidth then
      table.insert(newVirtText, chunk)
    else
      chunkText = truncate(chunkText, targetWidth - curWidth)
      local hlGroup = chunk[2]
      table.insert(newVirtText, { chunkText, hlGroup })
      chunkWidth = vim.fn.strdisplaywidth(chunkText)
      -- str width returned from truncate() may less than 2nd argument, need padding
      if curWidth + chunkWidth < targetWidth then
        padding = padding .. (" "):rep(targetWidth - curWidth - chunkWidth)
      end
      break
    end
    curWidth = curWidth + chunkWidth
  end

  local dot = " ⋯  "

  table.insert(newVirtText, { dot, "UfoFoldedEllipsis" })
  table.insert(newVirtText, { suffix, "MoreMsg" })
  table.insert(newVirtText, { dot, "UfoFoldedEllipsis" })

  for _, v in ipairs(end_virt_text) do
    table.insert(newVirtText, v)
  end

  table.insert(newVirtText, { padding, "" })

  return newVirtText
end

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return { "treesitter", "indent" }
  end,
  enable_fold_end_virt_text = true,
  fold_virt_text_handler = handler,
})
