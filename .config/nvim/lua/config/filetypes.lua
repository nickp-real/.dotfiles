vim.filetype.add({
  extension = { mdx = "markdown.mdx" },
  pattern = {
    -- INFO: Match filenames like - ".env.example", ".env.local" and so on
    ["%.env%.[%w_.-]+"] = "sh",
    ["%.[%w_.-]+%.gitconfig"] = "gitconfig",
    [".*/hypr/.+%.conf"] = "hyprlang",
    ["Dockerfile.*"] = "dockerfile",
  },
})
