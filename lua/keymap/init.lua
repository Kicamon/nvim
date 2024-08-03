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
  -- lsp
  ['<leader>wa'] = vim.lsp.buf.add_workspace_folder,
  ['<leader>wr'] = vim.lsp.buf.remove_workspace_folder,
  ['d[']         = vim.diagnostic.goto_prev,
  ['d]']         = vim.diagnostic.goto_next,
  ['<leader>wl'] = function() vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  -- gitsigns
  ['g[']         = cmd('silent lua require"gitsigns".prev_hunk()'),
  ['g]']         = cmd('silent lua require"gitsigns".next_hunk()'),
  ['<leader>H']  = cmd('lua require"gitsigns".preview_hunk_inline()'),
  ['<leader>gd'] = cmd('lua require"gitsigns".diffthis("~")'),
})

map.n('<leader>wl', function()
  vim.notify(vim.inspect(vim.lsp.buf.list_workspace_folders()))
end)

-- guard
map.nv({
  [';f'] = cmd('GuardFmt'),
})

-- lspsaga toggle terminal
map.nt({
  ['<leader>tt'] = cmd('Lspsaga outline'),
})
