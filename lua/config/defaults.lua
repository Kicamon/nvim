vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.ttyfast = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ttimeoutlen = 0
vim.opt.timeout = false
vim.opt.showmode = false
vim.opt.virtualedit = 'block'
vim.opt.conceallevel = 0
vim.opt.showtabline = 1
vim.opt.laststatus = 3
vim.opt.signcolumn = 'yes'
vim.opt.breakindent = true
vim.opt.spelloptions = 'camel'
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 99
vim.opt.list = true
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.completeopt = "menu,menuone,noselect,popup"
vim.opt.fillchars = {
  stl = ' ',
  stlnc = '-',
  msgsep = ' ',
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
vim.opt.cmdheight = 0
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.colorcolumn = '0'
vim.opt.undofile = true
vim.opt.updatetime = 100
vim.opt.redrawtime = 1500

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
  pattern = { 'c', 'cpp', 'text' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
vim.api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', command = [[startinsert]] })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.md', '*.txt' }, command = 'setlocal wrap', })
vim.api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local pos = vim.fn.getpos("'\"")
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end
})
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

require('user.user')
