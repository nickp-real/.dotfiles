vim.filetype.add({
  extension = { mdx = "mdx" },
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "dotenv",
    ["%.[%w_.-]+%.gitconfig"] = "gitconfig",
  },
})
