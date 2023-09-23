vim.opt.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.opt.ttyfast = true
vim.opt.autochdir = true
vim.g.mapleader = ' '
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { '*.c', '*.cpp', '*.txt', 'c.snippets', 'cpp.snippets' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ttimeoutlen = 0
vim.opt.timeout = false
vim.opt.virtualedit = 'block'
vim.opt.conceallevel = 0
vim.opt.showtabline = 2
vim.opt.laststatus = 2
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = 'tab:┃ ,trail:▫'
vim.opt.scrolloff = 6
vim.opt.colorcolumn = '-1'
vim.opt.cmdheight = 1
vim.opt.fillchars = {
  vert = '┃',
}
vim.cmd([[
silent !mkdir -p $HOME/.config/nvim/tmp/undo
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]])
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
-- vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })
vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
]])

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md, *.txt", command = "setlocal wrap", })

require("user.tools")
require("user.cursor")
require("user.md-snippets")
