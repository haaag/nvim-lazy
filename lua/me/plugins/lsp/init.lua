-- lsp-config

local Utils = require('me.plugins.lsp.utils')

return {

  { -- https://github.com/j-hui/fidget.nvim
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    opts = {
      notification = {
        window = { winblend = 0 },
      },
    },
    enabled = true,
  },

  { -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    event = 'InsertEnter',
    cmd = { 'LspStart' },
    keys = { '<leader>ls', '<CMD>LspStart<CR>', desc = 'lsp start' },
    enabled = true,
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      { -- https://github.com/williamboman/mason.nvim
        'mason.nvim',
        opts = {
          ui = {
            icons = {
              package_installed = '●',
              package_pending = '➜',
              package_uninstalled = '○',
            },
          },
        },
      },
      'williamboman/mason-lspconfig.nvim', -- https://github.com/williamboman/mason-lspconfig.nvim
    },
    ---@class PluginLspOpts
    opts = {
      inlay_hints = { enabled = true },
      document_highlight = { enabled = true },
      servers = {
        bashls = {},
        clangd = { autostart = false },
        marksman = {},
        jsonls = { autostart = false },
        taplo = {},
        docker_compose_language_service = {
          autostart = true,
        },
        ruff_lsp = {
          autostart = true,
          settings = {
            ruff_lsp = {
              fix = false,
            },
          },
        },
      },
      setup = {},
    },
    ---@param opts PluginLspOpts
    config = function(_, opts)
      -- diagnostics
      local diagnostic = require('me.plugins.lsp.diagnostic')
      diagnostic.set_keys()
      diagnostic.set_handlers()
      vim.diagnostic.config(diagnostic.defaults())

      Utils.logfile_size()
      Utils.on_attach(function(_, bufnr)
        require('me.plugins.lsp.keys').on_attach(bufnr)
      end)

      local servers = opts.servers
      local capabilities = Utils.capabilities()

      require('mason-lspconfig').setup({ ensure_installed = vim.tbl_keys(servers) })
      require('mason-lspconfig').setup_handlers({
        function(server)
          local server_opts = servers[server] or {}
          server_opts.capabilities = capabilities
          if opts.setup[server] then
            if opts.setup[server](server, server_opts) then
              return
            end
          elseif opts.setup['*'] then
            if opts.setup['*'](server, server_opts) then
              return
            end
          end
          require('lspconfig')[server].setup(server_opts)
        end,
      })
    end,
  },

  { -- https://github.com/williamboman/mason.nvim
    'williamboman/mason.nvim',
    cmd = 'Mason',
    enabled = true,
    opts = {
      ensure_installed = {
        'stylua',
        'ruff',
        'shfmt',
        'prettier',
        'debugpy',
        'eslint_d',
        'shellcheck',
        'markdownlint',
        'write-good',
        'goimports',
        'golangci-lint',
        'alex',
        'staticcheck',
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      for _, tool in ipairs(opts.ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then
          p:install()
        end
      end
    end,
  },
}
