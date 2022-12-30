return {
  "TimUntersberger/neogit",
  cmd = "Neogit",
  config = {
    kind = "split",
    signs = {
      -- { CLOSED, OPENED }
      section = { "", "" },
      item = { "", "" },
      hunk = { "", "" },
    },
    integrations = { diffview = true },
  },
  keys = {
    { "<leader>go", "<CMD>Neogit<CR>", desc = "Neo[G]it [O]pen" },
  },
}