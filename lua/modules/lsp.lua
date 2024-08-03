return {
  'neovim/nvim-lspconfig',
  lazy = true,
  ft = vim.g.fts,
  dependencies = {
    'nvimdev/lspsaga.nvim',
  },
  config = function()
    local servers = {
      bashls = {},
      clangd = {
        capabilities = {
          textDocument = {
            completion = {
              completionItem = {
                snippetSupport = false,
              },
            },
          },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--header-insertion=never",
          "--header-insertion-decorators=false",
        },
        root_dir = function(fname)
          return require("lspconfig").util.root_pattern(unpack({
            --reorder
            'Makefile',
            'compile_commands.json',
            '.clangd',
            '.clang-tidy',
            '.clang-format',
            'compile_flags.txt',
            'configure.ac', -- AutoTools
          }))(fname) or require("lspconfig").util.find_git_ancestor(fname)
        end,
      },
      jsonls = {},
      html = {},
      cssls = {},
      tsserver = {},
      lua_ls = {
        cmd = {
          "lua-language-server",
          "--locale=zh-cn",
        },
        settings = {
          Lua = {
            diagnostics = {
              unusedLocalExclude = { '_*' },
              globals = { 'vim' },
              disable = {
                'luadoc-miss-see-name',
                'undefined-field',
              },
            },
            runtime = {
              version = 'LuaJIT',
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME .. '/lua',
                '${3rd}/busted/library',
                '${3rd}/luv/library',
              },
              checkThirdParty = false,
            },
            completion = {
              callSnippet = 'Replace',
            },
          },
        },
      },
      pyright = {},
      vimls = {},
    }

    local on_attach = function(client, _)
      vim.opt.omnifunc = 'v:lua.vim.lsp.omnifunc'
      client.server_capabilities.semanticTokensProvider = nil
    end

    require('lspsaga').setup({
      outline = {
        keys = {
          quit = 'Q',
          toggle_or_jump = '<cr>',
        }
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
        }
      },
      code_action = {
        keys = {
          quit = 'Q',
        }
      },
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    for server, config in pairs(servers) do
      require('lspconfig')[server].setup(vim.tbl_deep_extend('force', {
        on_attach = on_attach,
        capabilities = capabilities,
      }, config))
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
      }
    })

    vim.diagnostic.config({
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = '🤣',
          [vim.diagnostic.severity.WARN] = '🧐',
          [vim.diagnostic.severity.INFO] = '🫠',
          [vim.diagnostic.severity.HINT] = '🤔',
        }
      }
    })

    vim.api.nvim_create_autocmd('CursorHold', {
      callback = function()
        local opts = {
          focusable = false,
          close_events = { 'BufLeave', 'CursorMoved', 'InsertEnter', 'FocusLost' },
          border = 'rounded',
          source = 'always',
          prefix = ' ',
          scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
      end
    })
  end,
}
