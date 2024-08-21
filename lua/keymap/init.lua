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
  ['<leader>ra'] = cmd('Yazi'),
  ['<leader>rh'] = cmd('Yazi left'),
  ['<leader>rj'] = cmd('Yazi down'),
  ['<leader>rk'] = cmd('Yazi up'),
  ['<leader>rl'] = cmd('Yazi right'),
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
