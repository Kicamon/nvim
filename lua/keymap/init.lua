require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- fzflua
  ['<leader>ff'] = cmd('FzfLua files'),
  ['<leader>fw'] = cmd('FzfLua live_grep'),
  ['<leader>fh'] = cmd('FzfLua helptags'),
  ['<leader>fo'] = cmd('FzfLua oldfiles'),
  -- lspsaga
  ['<leader>pd'] = cmd('Lspsaga peek_definition'),
  ['<leader>pr'] = cmd('Lspsaga finder ref'),
  ['<Leader>dw'] = cmd('Lspsaga show_workspace_diagnostics'),
  ['<Leader>db'] = cmd('Lspsaga show_buf_diagnostics'),
  ['<leader>K'] = cmd('Lspsaga hover_doc'),
  ['<leader>rn'] = cmd('Lspsaga rename ++project'),
  ['<leader>ca'] = cmd('Lspsaga code_action'),
  ['<leader>ot'] = cmd('Lspsaga outline'),
  ['d['] = cmd('Lspsaga diagnostic_jump_prev'),
  ['d]'] = cmd('Lspsaga diagnostic_jump_next'),
  -- gitsigns
  ['g['] = cmd('silent lua require"gitsigns".prev_hunk()'),
  ['g]'] = cmd('silent lua require"gitsigns".next_hunk()'),
  ['<leader>H'] = cmd('lua require"gitsigns".preview_hunk_inline()'),
  ['<leader>gd'] = cmd('lua require"gitsigns".diffthis("~")'),
  -- code_running
  ['<F5>'] = cmd('Run'),
  ['<F10>'] = cmd('Run center'),
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
  ['rs'] = function()
    require('internal.surround').remove_surround()
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
})

map.v({
  -- surround
  ['S'] = function()
    require('internal.surround').add_surround()
  end,
  --  quick_substitute
  ['<leader>ss'] = function()
    require('internal.quick_substitute').quick_substitute()
  end,
})

map.nx({
  -- guard
  [';f'] = cmd('Guard fmt'),
  -- wildfire
  ['<cr>'] = function()
    require('internal.wildfire').wildfire()
  end,
})

map.nox({
  -- flash
  ['s'] = function()
    require('flash').jump()
  end,
})

map.ni({
  ['<c-t>'] = function()
    require('internal.toggle_mark').toggle_mark()
  end,
})
