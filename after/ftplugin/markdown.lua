local map = require('core.keymap')
local function keymap(bufnr)
  -- markdonw snippets
  map.i({
    ['<leader><leader>'] = '<esc>/<++><cr>:nohlsearch<cr>"_c4l',
    ['《'] = '《》<c-o>i',
    ['》'] = '> ',
    ['（'] = '（）<c-o>i',
    ['“'] = '“”<c-o>i',
    ['”'] = '“”<c-o>i',
    ['·b'] = '****<c-o>F*',
    ['·s'] = '~~~~<c-o>F~',
    ['·h'] = '====<c-o>F=',
    ['·i'] = '**<c-o>i',
    ['·d'] = '``<c-o>i',
    ['·c'] = '```<Enter>```<c-o>k',
    ['·m'] = '- [ ] ',
    ['·p'] = '![](<++>)<c-o>F]',
    ['·a'] = '[](<++>)<c-o>F]',
    ['·l'] = '--- ',
    ['·t'] = '[toc]',
    ['·1'] = '# ',
    ['·2'] = '## ',
    ['·3'] = '### ',
    ['·4'] = '#### ',
    ['·5'] = '##### ',
    ['·6'] = '###### ',
    [',b'] = '****<c-o>F*',
    [',s'] = '~~~~<c-o>F~',
    [',h'] = '====<c-o>F=',
    [',i'] = '**<c-o>i',
    [',d'] = '``<c-o>i',
    [',c'] = '```<Enter>```<c-o>k',
    [',m'] = '- [ ] ',
    [',p'] = '![](<++>)<c-o>F]',
    [',a'] = '[](<++>)<c-o>F]',
    [',l'] = '--- ',
    [',t'] = '[toc]',
    [',1'] = '# ',
    [',2'] = '## ',
    [',3'] = '### ',
    [',4'] = '#### ',
    [',5'] = '##### ',
    [',6'] = '###### ',
  }, { buf = bufnr })

  -- paste image
  map.n('<leader>P', function()
    require('internal.image').paste()
  end, { buf = bufnr })

  -- enter file
  map.nx('<cr>', function()
    require('internal.wiki').open_create()
  end, { buf = bufnr })

  map.i('|', function()
    require('internal.markdown_table_format').format_markdown_table_lines()
  end, { buf = bufnr })
end
keymap(vim.api.nvim_get_current_buf())
