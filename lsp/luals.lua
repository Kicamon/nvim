return {
  cmd = { 'lua-language-server', '--locale=zh-cn' },
  filetypes = { 'lua' },
  root_markers = {
    '.luarc.json',
    '.luarc.jsonc',
    '.luacheckrc',
    '.stylua.toml',
    'stylua.toml',
    'selene.toml',
    'selene.yml',
    '.git',
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
}
