local M = {
  "kevinhwang91/nvim-ufo",
  event = "BufReadPost",
  dependencies = "kevinhwang91/promise-async",
}

function M.config()
  local ufo = require("ufo")
  local promise = require("promise")

  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ("  %d "):format(endLnum - lnum)
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
          suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, "MoreMsg" })
    return newVirtText
  end

  local ftMap = {
    -- vim = 'indent',
    python = { "indent" },
    -- git = ''
  }

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
      return ftMap[filetype] or customizeSelector
    end,
    -- provider_selector = function(bufnr, filetype, buftype)
    --   return { "treesitter", "indent" }
    -- end,
    fold_virt_text_handler = handler,
  })
end

return M
