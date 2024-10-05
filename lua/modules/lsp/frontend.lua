local servers = {
  clangd = {
    capabilities = {
      textDocument = { completion = { completionItem = { snippetSupport = false } } },
    },
    cmd = {
      'clangd',
      '--background-index',
      '--header-insertion=never',
      '--header-insertion-decorators=false',
    },
    -- init_options = { fallbackFlags = { '-std=c++23' } },
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
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
        runtime = { version = 'LuaJIT' },
        workspace = {
          library = {
            vim.env.VIMRUNTIME .. '/lua',
            '${3rd}/busted/library',
            '${3rd}/luv/library',
          },
          checkThirdParty = false,
        },
        completion = { callSnippet = 'Replace' },
      },
    },
  },
  pyright = {
    root_dir = function(fname)
      return require('lspconfig').util.root_pattern(unpack({
        '.pyproject.toml',
        'main.py',
        '.git',
      }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
    end,
    single_file_support = true,
  },
  bashls = {},
  jsonls = {},
  html = {},
  cssls = {},
  ts_ls = {},
  vimls = {},
}

return servers
