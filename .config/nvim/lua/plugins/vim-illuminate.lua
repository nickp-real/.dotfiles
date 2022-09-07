local status_ok, illuminate = pcall(require, "illuminate")
if not status_ok then
  return
end

local ftbacklist = {
  "help",
  "NvimTree",
  "alpha",
  "TelescopePrompt",
  "Outline",
  "toggleterm",
  "packer",
  "startuptime",
  "dirvish",
  "fugitive",
  "mason",
  "man",
}

illuminate.configure({
  delay = 250,
  filetypes_denylist = ftbacklist,
})
