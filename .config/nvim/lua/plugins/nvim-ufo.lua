local status_ok, ufo = pcall(require, "ufo")
local promise_status_ok, promise = pcall(require, "promise")
if not (status_ok and promise_status_ok) then
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

local function customizeSelector(bufnr)
  local function handleFallbackException(err, providerName)
    if type(err) == "string" and err:match("UfoFallbackException") then
      return ufo.getFolds(providerName, bufnr)
    else
      return promise.reject(err)
    end
  end

  return ufo
    .getFolds("lsp", bufnr)
    :catch(function(err)
      return handleFallbackException(err, "treesitter")
    end)
    :catch(function(err)
      return handleFallbackException(err, "indent")
    end)
end

ufo.setup({
  provider_selector = function(bufnr, filetype, buftype)
    return customizeSelector
  end,
  -- provider_selector = function(bufnr, filetype, buftype)
  --   return { "treesitter", "indent" }
  -- end,
  enable_fold_end_virt_text = true,
  fold_virt_text_handler = handler,
})
