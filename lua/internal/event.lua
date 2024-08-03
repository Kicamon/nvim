local au = vim.api.nvim_create_autocmd

au('TermOpen', { pattern = 'term://*', command = [[startinsert]] })
au('BufEnter', {
  callback = function()
    local pos = vim.fn.getpos("'\"")
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end
})
au('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})
au('BufEnter', {
  once = true,
  callback = function()
    require('keymap')
    vim.cmd('set formatoptions-=ro')
  end
})
au({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    require('keymap.markdown')
  end
})
