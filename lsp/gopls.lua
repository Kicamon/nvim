return {
  cmd = { 'gopls', 'serve' },
  settings = {
    gopls = {
      usePlaceholders = true,
      completeUnimported = true,
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  filetypes = { 'go' },
}
