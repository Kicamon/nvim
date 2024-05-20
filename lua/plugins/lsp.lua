return {
  {
    'neovim/nvim-lspconfig',
    lazy = true,
    ft = vim.g.fts,
    dependencies = {
      'nvimdev/lspsaga.nvim',
    },
    config = function()
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
      local servers = {
        bashls = {},
        clangd = {
          cmd = {
            "clangd",
            "--background-index",
            "--header-insertion=never",
            "--header-insertion-decorators=false",
          }
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

      local on_attach = function(_, bufnr)
        local nmap = function(keys, func, desc)
          if desc then
            desc = 'LSP: ' .. desc
          end

          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
        end

        nmap('<leader>pd', '<cmd>Lspsaga peek_definition<CR>', 'Peek Definition')
        nmap('<leader>pr', '<cmd>Telescope lsp_references<CR>', 'Peek References')
        nmap('<leader>K', '<cmd>Lspsaga hover_doc<CR>', 'Hover Documentation')
        nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, 'Workspace Add Folder')
        nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Workspace Remove Folder')
        nmap('<leader>wl', function()
          vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end, 'Workspace List Folders')
        nmap('<leader>rn', '<cmd>Lspsaga rename ++project<cr>', 'Rename')
        nmap('<leader>ca', '<cmd>Lspsaga code_action<CR>', 'Code Action')
        nmap('<leader>ot', '<cmd>Lspsaga outline<CR>', 'OutLine')
        nmap('d[', vim.diagnostic.goto_prev, 'Diangostics Prev')
        nmap('d]', vim.diagnostic.goto_next, 'Diangostics Next')
      end

      local capabilities = require('cmp_nvim_lsp').default_capabilities()

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

      for server, config in pairs(servers) do
        require('lspconfig')[server].setup(vim.tbl_deep_extend('keep', {
          on_attach = on_attach,
          capabilities = capabilities,
        }, config))
      end

      vim.diagnostic.config({
        virtual_text = {
          prefix = '❯',
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
}
