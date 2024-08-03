local map = require('core.keymap')
local cmd = map.cmd

map.n({
  ['W']                = cmd('w'),
  ['Q']                = cmd('q'),
  ['B']                = cmd('bd'),
  ['ca']               = cmd('silent %y+'),
  ['<leader>sc']       = cmd('set spell!'),
  ['<leader>sw']       = cmd('set wrap!'),
  ['<leader><cr>']     = cmd('noh'),
  ['<leader><leader>'] = '/<++><CR>:noh<CR>"_c4l',
  ['j']                = 'gj',
  ['k']                = 'gk',
  ['H']                = '^',
  ['J']                = '<c-d>',
  ['K']                = '<c-u>',
  ['L']                = '$',
  ['<leader>sh']       = cmd('set nosplitright | vsplit'),
  ['<leader>sj']       = cmd('set splitbelow | split'),
  ['<leader>sk']       = cmd('set nosplitbelow | split'),
  ['<leader>sl']       = cmd('set splitright | vsplit'),
  ['<leader>smv']      = '<c-w>t<c-W>H',
  ['<leader>smh']      = '<c-w>t<c-W>K',
  ['<leader>W']        = '<c-w>w',
  ['tn']               = cmd('tabnext'),
  ['tp']               = cmd('tabprevious'),
  ['tu']               = cmd('tabnew'),
  ['tt']               = cmd('silent 20 Lex'),
})

map.v({
  ['N'] = ':normal',
  ['Y'] = '"+y',
  ['H'] = '^',
})

map.t({
  ['<c-n>'] = '<C-\\><C-N>',
  ['<c-o>'] = '<C-\\><C-N><C-O>',
})

map.i({
  ['<c-l>'] = '<Right>',
})

map.nv('<leader>cc', function()
  return require('vim._comment').operator() .. '_'
end, { expr = true })
