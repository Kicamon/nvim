"============================================
" ███╗   ███╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
" ████╗ ████║╚██╗ ██╔╝██║   ██║██║████╗ ████║
" ██╔████╔██║ ╚████╔╝ ██║   ██║██║██╔████╔██║
" ██║╚██╔╝██║  ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║ ╚═╝ ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝     ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
"============================================

"====================================
"===  Basic setting for vim use   ===
"====================================

" 行号显示与相对行号
set nu
set relativenumber
" tab缩进大小为4格
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autoindent
set smartindent
set termguicolors
" 高亮本行
set cursorline
"复制模式
map <M-p> :set paste<CR>
map <M-S-p> :set nopaste<CR>
"换行
set nowrap
map<M-w> :set wrap<CR>
map<M-S-w> :set nowrap<CR>
"撤销文件和备份文件保存位置
set undodir=~/.vimfiles/undofile
set backupdir=~/.vimfiles/backupfile
"复制粘贴
vnoremap <C-Insert> "+y
nnoremap <S-Insert> "*p
"离底行数
set scrolloff=4
"leader
let mapleader = "\<space>"
"渲染Tab和空格
setlocal list
set listchars=tab:▸\ ,trail:▫
"显示命令
set wildmenu
" insert模式下右移
imap <A-l> <Right>


" 引用外部文件
"md-snippets
source ~/.config/nvim/md-snippets.vim
"num-key
source ~/.config/nvim/num-key.vim
"一键编译运行
source ~/.config/nvim/run.vim
"输入法切换
source ~/.config/nvim/fcitx.vim

"====================================
"=== Plug config ====================
"====================================
"-----markdown-----
let g:mkdp_browser='chromium'
let g:table_mode_corner='|'	" 表格
map <M-e> :TableModeEnable<CR>
command TMR TableModeRealign
command TOC GenTocGitLab
let g:vim_markdown_conceal=0
"-----NERDTree-----
map <F12> :NERDTreeMirror<CR>
map <F12> :NERDTreeToggle<CR>


"-----luochen1990/rainbow-----
" 1. vscode defult 2. author defult 3. vscode show
"	\	'guifgs': ['#B21212', '#1B9CED','#FFFC00'],
"	\	'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
"	\	'guifgs': ['#C186BF', '#268EDB','#F79318'],
 let g:rainbow_conf = {
 \	'guifgs': ['#C186BF', '#268EDB','#F79318'],
 \	'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
 \	'operators': '_,_',
 \	'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
 \	'separately': {
 \		'*': {},
 \		'tex': {
 \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
 \		},
 \		'lisp': {
 \			'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
 \		},
 \		'vim': {
 \			'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
 \		},
 \		'html': {
 \			'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
 \		},
 \		'css': 0,
 \	}
 \}
let g:rainbow_active = 1

"-----mhinz/vim-startify-----
let g:startify_custom_header = [
			\ ' █████╗  ██████╗███╗   ███╗███████╗██████╗ ',
			\ '██╔══██╗██╔════╝████╗ ████║██╔════╝██╔══██╗',
			\ '███████║██║     ██╔████╔██║█████╗  ██████╔╝',
			\ '██╔══██║██║     ██║╚██╔╝██║██╔══╝  ██╔══██╗',
			\ '██║  ██║╚██████╗██║ ╚═╝ ██║███████╗██║  ██║',
			\ '╚═╝  ╚═╝ ╚═════╝╚═╝     ╚═╝╚══════╝╚═╝  ╚═╝',
			\]
let g:startify_custom_footer = [
            \ '+------------------------------+',
            \ '|        Just for Fun!         |',
            \ '+----------------+-------------+',
            \]
let g:startify_files_number = 5
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')

"-----coc.nvim-----
set pumheight=10
set updatetime=100
set signcolumn=no
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
autocmd CursorHold * silent call CocActionAsync('highlight')

"-----airline-----
"set ambiwidth=double
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1      "tabline中当前buffer两端的分隔字符
let g:airline#extensions#tabline#left_sep = ' '   "tabline中未激活buffer两端的分隔字符
let g:airline#extensions#tabline#left_alt_sep = '|'      "tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>

"-----octol/vim-cpp-enhanced-highlight-----
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"-----vim-autoformat/vim-autoformat-----
let g:formatdef_clangformat_microsoft = '"clang-format -style microsoft -"'
let g:formatters_cpp = ['clangformat_microsoft']
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0
noremap <C-i> :Autoformat<CR>
let g:autoformat_verbosemode=1

call plug#begin('~/.config/nvim/plugged')
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'Yggdroot/indentLine'
Plug 'crusoexia/vim-monokai'
Plug 'luochen1990/rainbow'
Plug 'preservim/nerdtree'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'preservim/vim-markdown'
Plug 'dhruvasagar/vim-table-mode'
Plug 'mzlogin/vim-markdown-toc'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'ferrine/md-img-paste.vim'
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }
Plug 'preservim/nerdcommenter'
Plug 'vim-autoformat/vim-autoformat'
Plug 'ryanoasis/vim-devicons'
Plug 'honza/vim-snippets'
call plug#end()
