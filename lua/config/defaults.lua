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
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile", "FileType" }, {
  pattern = { 'c', 'cpp', 'txt', 'c.snippets', 'cpp.snippets' },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.ttimeoutlen = 0
vim.opt.timeout = false
vim.opt.virtualedit = 'block'
vim.opt.conceallevel = 0
vim.opt.showtabline = 3
vim.opt.laststatus = 3
vim.opt.signcolumn = "yes"
vim.opt.list = true
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.fillchars = {
  vert = '│',
}
vim.opt.cmdheight = 1
vim.opt.scrolloff = 6
vim.opt.colorcolumn = '0'
vim.opt.undofile = true
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
vim.api.nvim_create_autocmd("TermOpen", { pattern = "term://*", command = [[startinsert]] })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md, *.txt", command = "setlocal wrap", })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
  end
})

require("user.tools")
require("user.cursor")
require("user.md-snippets")
