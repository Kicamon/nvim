require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- code_running
  ['<F5>'] = function()
    require('internal.code_running').running(false)
  end,
  ['<F10>'] = function()
    require('internal.code_running').running(true)
  end,
  -- yazi
  ['<leader>ra'] = function()
    require('internal.yazi').yazi('edit')
  end,
  ['<leader>rh'] = function()
    require('internal.yazi').yazi('vsplit', 'left')
  end,
  ['<leader>rj'] = function()
    require('internal.yazi').yazi('split', 'down')
  end,
  ['<leader>rk'] = function()
    require('internal.yazi').yazi('split', 'up')
  end,
  ['<leader>rl'] = function()
    require('internal.yazi').yazi('vsplit', 'right')
  end,
  -- wiki
  ['<leader>ww'] = function()
    require('internal.wiki').open_wiki()
  end,
  -- surround
  ['cs'] = function()
    require('internal.surround').change_surround()
  end,
  -- tab_to_space
  ['<leader>ts'] = function()
    require('internal.tab_to_space').tab_to_space()
  end,
  -- invert_word
  ['<leader>iw'] = function()
    require('internal.invert_word').invert_word()
  end,
  -- toggle term
  ['<c-f>'] = function()
    require('internal.toggle_term').toggle()
  end,
})

map.t({
  -- toggle term
  ['<c-f>'] = function()
    require('internal.toggle_term').toggle()
  end,
  ['<c-p>'] = function()
    require('internal.toggle_term').prev()
  end,
  ['<c-n>'] = function()
    require('internal.toggle_term').next()
  end,
  ['<c-a>'] = function()
    require('internal.toggle_term').new()
  end,
  ['<c-d>'] = function()
    require('internal.toggle_term').delete()
  end,
  ['<c-r>'] = function()
    require('internal.toggle_term').right()
  end,
  ['<c-c>'] = function()
    require('internal.toggle_term').center()
  end,
})

map.v({
  -- surround
  ['S'] = function()
    require('internal.surround').add_surround()
  end,
})

map.nx({
  --  quick_substitute
  ['<leader>ss'] = function()
    require('internal.quick_substitute').quick_substitute()
  end,
  -- wildfire
  ['<cr>'] = function()
    require('internal.wildfire').wildfire()
  end,
})
