require('keymap.remap')
local map = require('core.keymap')
local cmd = map.cmd

map.n({
  -- telescope
  ['<leader>ff'] = cmd('Telescope find_files find_command=rg,--ignore,--hidden,--files'),
  ['<leader>fw'] = cmd('Telescope live_grep'),
  ['<leader>pr'] = cmd('Telescope lsp_references'),
  -- flybuf
  ['<leader>b']  = cmd('FlyBuf'),
  -- lspsaga
  ['<leader>pd'] = cmd('Lspsaga peek_definition'),
  ['<leader>K']  = cmd('Lspsaga hover_doc'),
  ['<leader>rn'] = cmd('Lspsaga rename ++project'),
  ['<leader>ca'] = cmd('Lspsaga code_action'),
  ['<leader>ot'] = cmd('Lspsaga outline'),
  ['<leader>tt'] = cmd('Lspsaga term_toggle'),
  ['d[']         = cmd('Lspsaga diagnostic_jump_prev'),
  ['d]']         = cmd('Lspsaga diagnostic_jump_next'),
  -- lsp
  ['<leader>wa'] = vim.lsp.buf.add_workspace_folder,
  ['<leader>wr'] = vim.lsp.buf.remove_workspace_folder,
  ['<leader>wl'] = function()
    vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end,
  -- gitsigns
  ['g[']         = cmd('silent lua require"gitsigns".prev_hunk()'),
  ['g]']         = cmd('silent lua require"gitsigns".next_hunk()'),
  ['<leader>H']  = cmd('lua require"gitsigns".preview_hunk_inline()'),
  ['<leader>gd'] = cmd('lua require"gitsigns".diffthis("~")'),
  -- yazi
  ['<leader>ra'] = function()
    require('internal.Yazi').Yazi('edit')
  end,
  ['<leader>rh'] = function()
    require('internal.Yazi').Yazi('vsplit', 'left')
  end,
  ['<leader>rj'] = function()
    require('internal.Yazi').Yazi('split', 'down')
  end,
  ['<leader>rk'] = function()
    require('internal.Yazi').Yazi('split', 'up')
  end,
  ['<leader>rl'] = function()
    require('internal.Yazi').Yazi('vsplit', 'right')
  end,
  -- wiki
  ['<leader>ww'] = function() require('internal.Wiki').OpenWiki() end,
  -- surround
  ['cs']         = function()
    require('internal.Surround').Change_Surround()
  end,
  -- TabToSpace
  ['<leader>ts'] = function()
    require('internal.TabToSpace').TabToSpace()
  end,
  -- GetNode
  ['<leader>N']  = function()
    require('internal.GetNode').GetNode()
  end,
})

map.v({
  -- Surround
  ['S'] = function()
    require('internal.Surround').Add_Surround()
  end,
  -- Align
  ['ga'] = function()
    require('internal.Align').align()
  end
})

map.nv({
  -- guard
  [';f'] = cmd('GuardFmt'),
  --  QuickSubstitute
  ['<leader>ss'] = function()
    require('internal.QuickSubstitute').QuickSubstitute()
  end,
  -- Wildfire
  ['<cr>'] = function()
    require('internal.Wildfire').Wildfire()
  end,
})
