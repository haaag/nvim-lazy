-- diagnostic.lua

local enabled = true

local M = {}

function M.config()
  return {
    virtual_lines = false,
    virtual_text = false,
    --[[ virtual_text = {
      prefix = " ",
      source = "always",
    }, ]]
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }
end

function M.set_signs()
  local icons = require("me.config.icons").icons
  for type, icon in pairs(icons.lsp.diagnostic) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

function M.set_handlers()
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "single",
    silent = true,
    focusable = false,
    close_events = { "InsertCharPre", "CursorMoved" },
  })
end

function M.toggle_diagnostics()
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
  else
    vim.diagnostic.disable()
  end
end

function M.set_keys()
  vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "[D]iagnostic Prev" })
  vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "[D]iagnostic Next" })
  vim.keymap.set("n", "[a", vim.diagnostic.open_float, { desc = "[D]iagnostic Float" })
  vim.keymap.set("n", "]a", vim.diagnostic.open_float, { desc = "[D]iagnostic Float" })
  vim.keymap.set("n", "<leader>ld", M.toggle_diagnostics, { desc = "[D]iagnostic Toggle" })
end

function M.setup()
  M.set_signs()
  M.set_keys()
  M.set_handlers()
end

return M
