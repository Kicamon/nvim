return function()
  require('nvim-highlight-colors').setup({
    render = 'virtual',
    virtual_symbol = '■',
    virtual_symbol_position = 'eol',
  })
end
