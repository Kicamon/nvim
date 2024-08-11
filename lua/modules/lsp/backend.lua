local config = {}
local servers = require('modules.lsp.frontend')

function config.lsp()
  local on_attach = function(client, _)
    vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
    client.server_capabilities.semanticTokensProvider = nil
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- local capabilities = vim.tbl_deep_extend(
  --   'force',
  --   vim.lsp.protocol.make_client_capabilities(),
  --   require('autocomplete.capabilities')
  -- )

  for server, conf in pairs(servers) do
    require('lspconfig')[server].setup(vim.tbl_deep_extend('force', {
      on_attach = on_attach,
      capabilities = capabilities,
    }, conf))
  end

  vim.lsp.handlers['workspace/diagnostic/refresh'] = function(_, _, ctx)
    local ns = vim.lsp.diagnostic.get_namespace(ctx.client_id)
    local bufnr = vim.api.nvim_get_current_buf()
    vim.diagnostic.reset(ns, bufnr)
    return true
  end

  vim.diagnostic.config({
    virtual_text = {
      prefix = '❯',
    },
  })

  vim.diagnostic.config({
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = 'E',
        [vim.diagnostic.severity.WARN] = 'W',
        [vim.diagnostic.severity.INFO] = 'I',
        [vim.diagnostic.severity.HINT] = 'H',
      },
    },
  })
end

function config.lspsaga()
  require('lspsaga').setup({
    ui = {
      title = true,
      devicon = false,
    },
    outline = {
      keys = {
        quit = 'Q',
        toggle_or_jump = '<cr>',
      },
    },
    finder = {
      keys = {
        quit = 'Q',
        edit = '<C-o>',
        toggle_or_open = '<cr>',
      },
    },
    definition = {
      keys = {
        edit = '<C-o>',
        vsplit = '<C-v>',
      },
    },
    code_action = {
      keys = {
        quit = 'Q',
      },
    },
  })
end

return config
