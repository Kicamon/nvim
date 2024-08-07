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

return servers
