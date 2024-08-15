require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- telescope
  ['<leader>ff'] = cmd('Telescope find_files find_command=rg,--ignore,--hidden,--files'),
  ['<leader>fw'] = cmd('Telescope live_grep'),
  ['<leader>pr'] = cmd('Telescope lsp_references'),
  -- lspsaga
  ['<leader>pd'] = cmd('Lspsaga peek_definition'),
  ['<leader>K'] = cmd('Lspsaga hover_doc'),
  ['<leader>rn'] = cmd('Lspsaga rename ++project'),
  ['<leader>ca'] = cmd('Lspsaga code_action'),
  ['<leader>ot'] = cmd('Lspsaga outline'),
  ['<leader>tt'] = cmd('Lspsaga term_toggle'),
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
  -- flash
  ['s'] = function()
    require('flash').jump()
  end,
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
  -- get_node
  ['<leader>N'] = function()
    require('internal.get_node').get_node()
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
