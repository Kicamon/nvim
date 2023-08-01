vim.o.termguicolors = true
vim.env.NVIM_TUI_ENABLE_TRUE_COLOR = 1
vim.o.cursorline = true
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { '*.c', '*.cpp', '*.py', '*.txt' },
	callback = function()
		vim.o.tabstop = 4
		vim.o.shiftwidth = 4
		vim.o.softtabstop = 4
	end,
})
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { '*.c', '*.cpp', '*.py', '*.txt' },
	command = "setlocal expandtab"
})
vim.o.smarttab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.ttimeoutline = 0
vim.o.timeout = false
vim.o.virtualedit = 'block'
vim.o.conceallevel = 0
vim.o.showtabline = 2
vim.o.laststatus = 2
vim.o.formatoptions = vim.o.formatoptions:gsub('tc', '')
vim.o.list = true
vim.o.listchars = 'tab:┃ ,trail:▫'
vim.o.scrolloff = 6
vim.o.colorcolumn = 80
vim.opt.fillchars = { vert = '║' }
vim.cmd([[
silent !mkdir -p $HOME/.config/nvim/tmp/undo
if has('persistent_undo')
	set undofile
	set undodir=$HOME/.config/nvim/tmp/undo,.
endif
]])
vim.cmd([[au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]])
vim.api.nvim_create_autocmd("BufEnter", { pattern = "*", command = "silent! lcd %:p:h", })
vim.cmd([[autocmd TermOpen term://* startinsert]])
vim.cmd([[
augroup NVIMRC
    autocmd!
    autocmd BufWritePost .vim.lua exec ":so %"
augroup END
tnoremap <C-N> <C-\><C-N>
tnoremap <C-O> <C-\><C-N><C-O>
]])
vim.g.terminal_color_0  = '#000000'
vim.g.terminal_color_1  = '#FF5555'
vim.g.terminal_color_2  = '#50FA7B'
vim.g.terminal_color_3  = '#F1FA8C'
vim.g.terminal_color_4  = '#BD93F9'
vim.g.terminal_color_5  = '#FF79C6'
vim.g.terminal_color_6  = '#8BE9FD'
vim.g.terminal_color_7  = '#BFBFBF'
vim.g.terminal_color_8  = '#4D4D4D'
vim.g.terminal_color_9  = '#FF6E67'
vim.g.terminal_color_10 = '#5AF78E'
vim.g.terminal_color_11 = '#F4F99D'
vim.g.terminal_color_12 = '#CAA9FA'
vim.g.terminal_color_13 = '#FF92D0'
vim.g.terminal_color_14 = '#9AEDFE'

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, { pattern = "*.md", command = "setlocal wrap", })

require("user.tools")
require("user.cursor")
require("user.md-snippets")
