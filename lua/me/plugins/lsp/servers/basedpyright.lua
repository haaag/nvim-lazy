-- lsp.servers.pyright
return {
  { -- https://github.com/neovim/nvim-lspconfig
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        basedpyright = { -- https://github.com/DetachHead/basedpyright
          autostart = true,
          disableOrganizeImports = true,
          handlers = { ['textDocument/publishDiagnostics'] = function() end },
          on_attach = function(client, _)
            client.server_capabilities.semanticTokensProvider = nil
          end,
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                typeCheckingMode = 'off',
                useLibraryCodeForTypes = true,
              },
            },
          },
        },
        ruff = {
          enabled = true,
          autostart = true,
          settings = {
            ruff = {
              fix = false,
            },
          },
          -- stylua: ignore
          on_attach = function(client, bufnr)
            local map = vim.keymap.set
            map('n', '<leader>lo', Core.lsp.action['source.organizeImports'], { buffer = bufnr, desc = 'organize imports' })
            map('n', '<leader>lF', Core.lsp.action['source.fixAll'], { buffer = bufnr, desc = 'fix all' })
            -- Disable hover in favor of basedpyright
            if client.name == 'ruff' then
              client.server_capabilities.hoverProvider = false
            end
          end,
        },
      },
    },
  },

  { -- https://github.com/nvim-treesitter/nvim-treesitter
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'ninja', 'python', 'rst', 'toml' })
      end
    end,
  },

  { -- https://github.com/williamboman/mason.nvim
    'williamboman/mason.nvim',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'debugpy' })
      end
    end,
  },

  { -- https://github.com/mfussenegger/nvim-dap
    'mfussenegger/nvim-dap',
    optional = true,
    enabled = Core.config.debug,
    dependencies = { -- https://github.com/mfussenegger/nvim-dap-python
      { 'mfussenegger/nvim-dap-python', ft = 'python', enabled = Core.config.debug },
    },
    -- stylua: ignore
    keys = {
      { '<leader>dp', '', desc = '+python'},
      { '<leader>dpm', function() require('dap-python').test_method() end, desc = 'python: test method' },
      { '<leader>dpc', function() require('dap-python').test_class() end, desc = 'python: test class' },
      { '<leader>dpd', function() require('dap-python').debug_selection() end, desc = 'python: debug selection' },
    },
    opts = function()
      -- TODO: check if `pypath` exists
      local pypath = os.getenv('XDG_DATA_HOME') .. '/nvim/mason/packages/debugpy/venv/bin/python'
      require('dap').configurations.python = {
        {
          type = 'python',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          -- justMyCode = false,
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
              return cwd .. '/venv/bin/python'
            elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
              return cwd .. '/.venv/bin/python'
            else
              return vim.fn.exepath('python3') or vim.fn.exepath('python')
            end
          end,
        },
      }
      require('dap-python').setup(pypath)
    end,
  },

  { -- https://github.com/nvim-neotest/neotest
    'nvim-neotest/neotest',
    enabled = Core.config.testing,
    dependencies = { -- https://github.com/nvim-neotest/neotest-python
      { 'nvim-neotest/neotest-python', enabled = Core.config.testing },
    },
    opts = {
      adapters = {
        ['neotest-python'] = {},
      },
    },
  },
}
