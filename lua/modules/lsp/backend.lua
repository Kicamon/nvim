local config = {}
local servers = require('modules.lsp.frontend')

function config.lsp()
  local on_attach = function(client, _)
    vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
    client.server_capabilities.semanticTokensProvider = nil
  end

  local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

  vim.diagnostic.config({ signs = { text = { 'E', 'W', 'I', 'H' } } })
end

function config.lspsaga()
  require('lspsaga').setup({
    ui = {
      devicon = false,
      border = 'single',
    },
    outline = {
      keys = {
        toggle_or_jump = '<cr>',
      },
    },
    finder = {
      keys = {
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
  })
end

return config
