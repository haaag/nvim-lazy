return {
  { -- https://github.com/stevearc/conform.nvim
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    cmd = { 'ConformInfo' },
    enabled = true,
    config = function()
      local conform = require('conform')
      conform.setup({
        formatters_by_ft = {
          ['_'] = { 'trim_whitespace' },
          ['css'] = { 'prettier' },
          ['go'] = { 'goimports-reviser', 'golines', 'gofumpt', 'golines' },
          ['html'] = { 'prettier' },
          ['javascript'] = { 'prettier' },
          ['javascriptreact'] = { 'prettier' },
          ['json'] = { 'prettier' },
          ['jsonc'] = { 'prettier' },
          ['lua'] = { 'stylua' },
          ['markdown'] = { 'prettier' },
          ['markdown.mdx'] = { 'prettier' },
          ['python'] = { 'ruff_format', 'ruff_organize_imports' },
          ['sh'] = { 'shfmt' },
          ['typescript'] = { 'prettier' },
          ['typescriptreact'] = { 'prettier' },
          ['yaml'] = { 'prettier' },
        },

        formatters = {
          injected = { options = { ignore_errors = true } },
        },

        --[[ format_on_save = {
          lsp_fallback = true,
          timeout_ms = 3000,
        }, ]]
      })

      vim.keymap.set({ 'n', 'v' }, '<leader>lf', function()
        conform.format({ lsp_fallback = true, async = false, timeout_ms = 1000 })
      end, { desc = 'format file or range (in visual mode)' })
    end,
  },
}
