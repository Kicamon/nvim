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
  -- lsp
  ['<leader>wa'] = vim.lsp.buf.add_workspace_folder,
  ['<leader>wr'] = vim.lsp.buf.remove_workspace_folder,
  ['<leader>wl'] = function()
    vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
  -- gitsigns
  ['g['] = cmd('silent lua require"gitsigns".prev_hunk()'),
  ['g]'] = cmd('silent lua require"gitsigns".next_hunk()'),
  ['<leader>H'] = cmd('lua require"gitsigns".preview_hunk_inline()'),
  ['<leader>gd'] = cmd('lua require"gitsigns".diffthis("~")'),
  -- flybuf
  ['<leader>b'] = cmd('FlyBuf'),
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
  -- guard
  [';f'] = cmd('GuardFmt'),
  --  quick_substitute
  ['<leader>ss'] = function()
    require('internal.quick_substitute').quick_substitute()
  end,
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
