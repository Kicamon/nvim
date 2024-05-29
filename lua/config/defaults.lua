local opt, api = vim.opt, vim.api
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
opt.termguicolors = true
opt.ttyfast = true
opt.cursorline = true
opt.wrap = false
opt.number = true
opt.relativenumber = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.ttimeoutlen = 0
opt.timeout = false
opt.showmode = false
opt.virtualedit = 'block'
opt.conceallevel = 0
opt.showtabline = 1
opt.laststatus = 3
opt.signcolumn = 'yes'
opt.breakindent = true
opt.spelloptions = 'camel'
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.winwidth = 25
opt.pumheight = 15
opt.textwidth = 80
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.completeopt = "menu,menuone,noselect,popup"
opt.fillchars = {
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
opt.cmdheight = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = '0'
opt.undofile = true
opt.updatetime = 100
opt.redrawtime = 1500

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile', 'FileType' }, {
  pattern = { 'c', 'cpp', 'text' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
api.nvim_create_autocmd('TermOpen', { pattern = 'term://*', command = [[startinsert]] })
api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, { pattern = { '*.md', '*.txt' }, command = 'setlocal wrap', })
api.nvim_create_autocmd('BufReadPost', {
  callback = function()
    local pos = vim.fn.getpos("'\"")
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
  end
})
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})
api.nvim_create_autocmd('VimEnter', { command = 'set formatoptions-=ro' })

require('user.user')
