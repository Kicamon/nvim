return function ()
  vim.opt.listchars:append({ tab = '  ' })
  require('indentmini').setup({
    char = '│',
    exclude = {
      'help',
      'dashboard',
      'lazy',
      'markdown',
      'text',
    },
  })
end
