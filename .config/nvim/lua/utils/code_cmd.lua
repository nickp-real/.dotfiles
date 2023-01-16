local M = {}

M.run_command_table = {
  ["cpp"] = "g++ -Wall -O2 % -o %:r && ./%:r",
  ["c"] = "gcc % -o %:r && ./%:r",
  ["python"] = "python %",
  ["lua"] = "lua %",
  ["java"] = "javac % && java %:r",
  ["zsh"] = "zsh %",
  ["sh"] = "sh %",
  ["rust"] = "rustc % && ./%:r",
  ["go"] = "go run %",
  ["javascript"] = "node %",
  ["dart"] = "dart run %",
  ["bash"] = "bash %",
}

M.pattern_table = {
  ["cpp"] = "*.cpp",
  ["c"] = "*.c",
  ["python"] = "*.py",
  ["lua"] = "*.lua",
  ["java"] = "*.java",
  ["zsh"] = "*.zsh",
  ["sh"] = "*.sh",
  ["rust"] = "*.rust",
  ["go"] = "*.go",
  ["javascript"] = "*.js",
  ["dart"] = "*.dart",
  ["bash"] = "*.bash",
}

return M
