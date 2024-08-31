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
      'clangd',
      '--background-index',
      '--header-insertion=never',
      '--header-insertion-decorators=false',
    },
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        --reorder
        'Makefile',
        'compile_commands.json',
        '.clangd',
        '.clang-tidy',
        '.clang-format',
        'compile_flags.txt',
        'configure.ac', -- AutoTools
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
  },
  lua_ls = {
    cmd = {
      'lua-language-server',
      '--locale=zh-cn',
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
  rust_analyzer = {
    settings = {
      ['rust-analyzer'] = {
        imports = {
          granularity = {
            group = 'module',
          },
          prefix = 'self',
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
    single_file_support = true,
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        'Cargo.toml',
        'rust-project.json',
        'main.rs',
        '.git',
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
  },
  jsonls = {},
  html = {},
  cssls = {},
  tsserver = {},
  pyright = {
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        'pyproject.toml',
        'setup.py',
        'main.py',
        '.git',
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
    single_file_support = true,
  },
  vimls = {},
}

return servers
