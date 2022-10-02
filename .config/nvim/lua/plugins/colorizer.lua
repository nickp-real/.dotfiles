local status_ok, colorizer = pcall(require, "colorizer")
if not status_ok then
  return
end

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
colorizer.setup({
  "*",
  "!css",
  "!html",
  "!tsx",
  "!typescriptreact",
  "!jsx",
  "!javascriptreact",
  "!dart",
  "!packer",
  "!TelescopePrompt",
  "!NvimTree",
}, {
  css = true,
})

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
-- colorizer.setup({
--   'css';
--   'javascript';
--   html = { mode = 'background' };
-- }, { mode = 'foreground' })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
-- colorizer.setup({
-- 	"*", -- Highlight all files, but customize some others.
-- 	"!dart",
-- 	css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in css.
-- 	html = { names = false }, -- Disable parsing "names" like Blue or Gray
-- })

-- Exclude some filetypes from highlighting by using `!`
-- colorizer.setup({
-- 	"*", -- Highlight all files, but customize some others.
-- 	"!vim", -- Exclude vim from highlighting.
-- 	"!dart",
-- 	-- Exclusion Only makes sense if '*' is specified!
-- })
