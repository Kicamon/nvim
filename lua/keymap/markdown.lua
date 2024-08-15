local map = require('core.keymap')
local function markdown_keymap()
  -- markdonw snippets
  map.i({
    ['<leader><leader>'] = '<Esc>/<++><CR>:nohlsearch<CR>"_c4l',
    ['《'] = '《》<Esc>i',
    ['》'] = '> ',
    ['（'] = '（）<Esc>i',
    ['“'] = '“”<Esc>i',
    ['”'] = '“”<Esc>i',
    ['·b'] = '****<++><Esc>F*hi',
    ['·s'] = '~~~~<++><Esc>F~hi',
    ['·h'] = '====<++><Esc>F=hi',
    ['·i'] = '**<++><Esc>F*i',
    ['·d'] = '``<++><Esc>F`i',
    ['·c'] = '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA',
    ['·m'] = '- [ ] ',
    ['·p'] = '![](<++>)<++><Esc>F[a',
    ['·a'] = '[](<++>)<++><Esc>F[a',
    ['·l'] = '--- ',
    ['·t'] = '[toc]',
    ['·1'] = '#<Space><Enter><++><Esc>kA',
    ['·2'] = '##<Space><Enter><++><Esc>kA',
    ['·3'] = '###<Space><Enter><++><Esc>kA',
    ['·4'] = '####<Space><Enter><++><Esc>kA',
    ['·5'] = '#####<Space><Enter><++><Esc>kA',
    [',b'] = '****<++><Esc>F*hi',
    [',s'] = '~~~~<++><Esc>F~hi',
    [',h'] = '====<++><Esc>F=hi',
    [',i'] = '**<++><Esc>F*i',
    [',d'] = '``<++><Esc>F`i',
    [',c'] = '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA',
    [',m'] = '- [ ] ',
    [',p'] = '![](<++>)<++><Esc>F[a',
    [',a'] = '[](<++>)<++><Esc>F[a',
    [',l'] = '--- ',
    [',t'] = '[toc]',
    [',1'] = '#<Space><Enter><++><Esc>kA',
    [',2'] = '##<Space><Enter><++><Esc>kA',
    [',3'] = '###<Space><Enter><++><Esc>kA',
    [',4'] = '####<Space><Enter><++><Esc>kA',
    [',5'] = '#####<Space><Enter><++><Esc>kA',
  }, { buffer = true })

  -- paste image
  map.n('<leader>P', function()
    require('internal.image').paste()
  end, { buffer = true })

  -- enter file
  map.nx('<cr>', function()
    require('internal.wiki').open_create()
  end, { buffer = true })
end

return { markdown_keymap = markdown_keymap }
