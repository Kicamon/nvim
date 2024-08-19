"============================================
" ███╗   ███╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
" ████╗ ████║╚██╗ ██╔╝██║   ██║██║████╗ ████║
" ██╔████╔██║ ╚████╔╝ ██║   ██║██║██╔████╔██║
" ██║╚██╔╝██║  ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
" ██║ ╚═╝ ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
" ╚═╝     ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
"============================================

"user information
source ~/.config/nvim/usr/UserInformation.vim
"auto load
if empty(glob($NVIM.'/tmp'))
    silent !curl -fLo $HOME/.config/nvim/autoload/plug.vim --create-dirs
			    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    silent :! mkdir -p ~/.config/nvim/tmp/undo
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"====================================
"===  Basic setting for vim use   ===
"====================================
" leader
let mapleader = "\<space>"
" color
set termguicolors
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
let &t_ut=''
set t_CO=256
" highlight
syntax on
set cursorline
" wrap
set nowrap
" line number
set nu
set relativenumber
" tab size
set tabstop=2
set shiftwidth=2
set softtabstop=2
autocmd FileType c,cpp,python,text setlocal shiftwidth=4 | setlocal tabstop=4 | setlocal softtabstop=4
set autoindent
set smartindent
autocmd BufEnter *.txt,*.md setlocal expandtab
" ignore Uppercase and Lowercase
set ignorecase
set smartcase
" timeout
set ttimeoutlen=0
set notimeout
set virtualedit=block
" close the conceal
set conceallevel=0
" show lines
set showtabline=2
set laststatus=2
" show tab and space
set list
set listchars=tab:\┃\ ,trail:▫
" distance with top and bottom
set scrolloff=6
" wrap line
set colorcolumn=80
"window line
set fillchars=vert:\║
"cmd
set cmdheight=1
set noshowmode
" undo
set undofile
set undodir=$NVIM/tmp/undo
" cursor place last time
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" auto change dir
autocmd BufEnter * silent! lcd %:p:h
" change default key
noremap s <nop>
nnoremap C cl
nnoremap Q :q<cr>
nnoremap B :bd<cr>
nnoremap W :w<cr>
noremap I 0
vnoremap A $
nnoremap J 10j
nnoremap K 10k
vnoremap N :normal 
" windows operation
noremap sh :set nosplitright<CR>:vsplit<CR>
noremap sj :set splitbelow<CR>:split<CR>
noremap sk :set nosplitbelow<CR>:split<CR>
noremap sl :set splitright<CR>:vsplit<CR>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap smv <C-w>t<c-W>H
nmap smh <C-w>t<c-W>K
autocmd TermOpen term://* startinsert
tnoremap <C-n> <C-\><C-N>
tnoremap <C-o> <C-\><C-N><C-O>
"cursor move
nnoremap <expr>j (v:count==0?"gj":"j")
nnoremap <expr>k (v:count==0?"gk":"k")
" change buffers & tabs
nnoremap [b :bp<CR>
nnoremap ]b :bn<CR>
nnoremap tu :tabe<CR>:edit<space>
nnoremap tU :tab split<CR>
nnoremap tj :+tabnext<CR>
nnoremap tk :-tabnext<CR>
nnoremap tmj :+tabmove<CR>
nnoremap tmk :-tabmove<CR>
nnoremap <A-1> 1gt<CR>
nnoremap <A-2> 2gt<CR>
nnoremap <A-3> 3gt<CR>
nnoremap <A-4> 4gt<CR>
nnoremap <A-5> 5gt<CR>
nnoremap <A-6> 6gt<CR>
nnoremap <A-7> 7gt<CR>
nnoremap <A-8> 8gt<CR>
nnoremap <A-9> 9gt<CR>
nnoremap <A-0> 10gt<CR>
" copy and paste
"set clipboard=unnamedplus
vnoremap Y "+y
"nmap ca ggVGY<C-o>:echo " Copied!"<CR>
nmap ca :! xclip -sel c "%"<CR><CR>:echo " Copied!"<CR>
" spell check
nnoremap <leader>sc :set spell!<CR>
" wrap
nnoremap <leader>sw :set wrap!<CR>
" move
inoremap <A-l> <Right>
nnoremap <A-j> <cmd>m .+1<cr>==
nnoremap <A-k> <cmd>m .-2<cr>==
"inoremap <A-j> <esc><cmd>m .+1<cr>==gi
"inoremap <A-k> <esc><cmd>m .-2<cr>==gi
vnoremap <A-j> :m '>+1<cr>gv=gv
vnoremap <A-k> :m '<-2<cr>gv=gv
" change window size
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>
" find next <++>
nmap <leader><leader> /<++><CR>:noh<CR>"_c4l
" cancel search highlight
nnoremap <leader><CR> :noh<CR>
" open init
nnoremap <leader>vim :edit $NVIM/init.vim<CR>

"my tools
source $NVIM/usr/tools.vim
"md-snippets
source $NVIM/usr/md-snippets.vim
"num-key
source $NVIM/usr/cursor.vim

"====plugin management====
call plug#begin($NVIM.'/plugged')
"-----code-----
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': 'yarn install --frozen-lockfile'}
Plug 'honza/vim-snippets'
Plug 'neovim/nvim-lspconfig'
Plug 'SmiteshP/nvim-navic'
Plug 'MunifTanjim/nui.nvim'
Plug 'numToStr/Comment.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'dart-lang/dart-vim-plugin', { 'for': ['dart', 'vim-plug'] }
" heilight
Plug 'numirias/semshi', { 'do': ':UpdateRemotePlugins', 'for': ['python', 'vim-plug'] }
" commenter
Plug 'preservim/nerdcommenter'
" format
Plug 'akarl/autoformat.nvim'
" web
Plug 'norcalli/nvim-colorizer.lua'
" preview code segment and jump
Plug 'SmiteshP/nvim-navbuddy'
" acm
Plug 'xeluxee/competitest.nvim', { 'for': ['cpp', 'veil', 'vim-plug']}
"-----markdown&note-----
Plug 'dhruvasagar/vim-table-mode',{ 'for': ['markdown','vimwiki', 'vim-plug'] }
Plug 'mzlogin/vim-markdown-toc',{ 'for': ['markdown','vimwiki', 'vim-plug'] }
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install', 'for': ['markdown','vimwiki', 'vim-plug'] }
Plug 'img-paste-devs/img-paste.vim',{ 'for': ['markdown','vimwiki', 'vim-plug'] }
Plug 'dkarter/bullets.vim',{ 'for': ['markdown','vimwiki', 'vim-plug'] }
Plug 'vimwiki/vimwiki'
"-------edit------
"auto pairs
Plug 'windwp/nvim-autopairs'
" quick chose text
Plug 'gcmt/wildfire.vim'
" change the characters wrapping words
Plug 'tpope/vim-surround'
" more cursors
Plug 'mg979/vim-visual-multi'
" auto alignment
Plug 'junegunn/vim-easy-align'
" search files
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-file-browser.nvim'
" git
Plug 'lewis6991/gitsigns.nvim'
Plug 'sindrets/diffview.nvim'
" open link
Plug 'xiyaowong/link-visitor.nvim'
" undo tree
Plug 'mbbill/undotree'
" float ranger
Plug 'kevinhwang91/rnvimr'
"------beautify-------
" start page
Plug 'willothy/veil.nvim'
" notify
Plug 'rcarriga/nvim-notify'
" lines and bar
"Plug 'LucasTavaresA/simpleIndentGuides.nvim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'shellRaining/hlchunk.nvim', { 'for': ['cpp', 'c', 'python', 'lua','vim-plug'] }
"Plug 'mg979/vim-xtabline'
Plug 'akinsho/bufferline.nvim'
Plug 'petertriho/nvim-scrollbar'
Plug 'kevinhwang91/nvim-hlslens'
Plug 'utilyre/barbecue.nvim'
Plug 'm4xshen/smartcolumn.nvim'
" theme
Plug 'Kicamon/gruvbox'
"Plug 'ellisonleao/gruvbox.nvim'
" icons
Plug 'ryanoasis/vim-devicons'
Plug 'nvim-tree/nvim-web-devicons'
" rainbow parentheses
Plug 'luochen1990/rainbow'
"-----other------
" goyo
Plug 'junegunn/goyo.vim'
" sudo
Plug 'lambdalisue/suda.vim'
call plug#end()



"====================================
"=== Plug config ====================
"====================================

"=====beautify=====

"----theme and highlight----
colorscheme gruvbox

"----- veil.nvim -----
"lua require('veil').setup()
lua << EOF
local builtin = require("veil.builtin")

require('veil').setup({
  sections = {
    builtin.sections.animated(builtin.headers.frames_nvim, {
      hl = { fg = "#5de4c7" },
    }),
    builtin.sections.buttons({
      {
        icon = "",
        text = "New File",
        shortcut = "nfd",
        callback = function()
			vim.cmd('bd')
        end,
      },
      {
        icon = "",
        text = "Find Files",
        shortcut = "fdf",
        callback = function()
          require("telescope.builtin").find_files()
        end,
      },
      {
        icon = "",
        text = "Config",
        shortcut = "vim",
        callback = function()
          require("telescope").extensions.file_browser.file_browser({
            path = vim.fn.stdpath("config"),
          })
        end,
      },
      {
        icon = "",
        text = "Config",
        shortcut = "acm",
        callback = function()
			vim.cmd('CompetiTestReceive contest')
        end,
      },
    }),
  },
  mappings = {},
  startup = true,
  listed = false,
})
EOF

"--- simpleIndentGuides ---
"lua require("simpleIndentGuides").setup("┃")

"--- hlchunk.nvim ---
lua << EOF
require("hlchunk").setup({
	chunk = {
		enable = false,
	},
	indent = {
		enable = true,
		use_treesitter = false,
		chars = {
			"┃",
		},
		style = {
			'#00BFFF',
			'#B0E0E6',
			'#FF69B4',
		},
	},
	line_num = {
		enable = true,
		style = "#FFD700",
	},
	blank = {
    enable = false,
		chars = {
			"█",
		},
		style = {
			"#000000",
			"#0a0a0a"
		}
  }
})
EOF
autocmd BufEnter *.txt :DisableHL
autocmd BufLeave *.txt :EnableHL

"-----lualine----
lua << EOF
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignore
local colors = {
	bg       = '#3c3836',
	bglight  = '#504945',
	bgdark   = '#3f3d3f',
	fg       = '#bbc2cf',
	yellow   = '#F0E68C',
	cyan     = '#008080',
	darkblue = '#081633',
	green    = '#afd787',
	orange   = '#FF8800',
	violet   = '#a9a1e1',
	magenta  = '#c678dd',
	blue     = '#51afef',
	red      = '#ec5f67',
	pink     = '#FF69B4',
	snow     = '#FFFAFA',
	black    = '#000000',
	none     = '#282828',
}

local conditions = {
  buffer_not_empty = function()
	return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
	return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
	local filepath = vim.fn.expand('%:p:h')
	local gitdir = vim.fn.finddir('.git', filepath .. ';')
	return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
	-- Disable sections and component separators
	component_separators = '',
	section_separators = '',
	theme = {
	  -- We are going to use lualine_c an lualine_x as left and
	  -- right section. Both are highlighted by c theme .  So we
	  -- are just setting default looks o statusline
	  normal = { c = { fg = colors.fg, bg = colors.bg } },
	  inactive = { c = { fg = colors.fg, bg = colors.bg } },
	},
  },
  sections = {
	-- these are to remove the defaults
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},
	-- These will be filled later
	lualine_c = {},
	lualine_x = {},
  },
  inactive_sections = {
	-- these are to remove the defaults
	lualine_a = {},
	lualine_b = {},
	lualine_y = {},
	lualine_z = {},
	lualine_c = {},
	lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x at right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
	function()
		return ''
	end,
	padding = { right = 0 },
	color = function()
	local mode_color = {
		n = colors.green,
		i = colors.violet,
		v = colors.yellow,
		[''] = colors.yellow,
		V = colors.yellow,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		[''] = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		['r?'] = colors.cyan,
		['!'] = colors.red,
		t = colors.red,
	}
	return { bg = colors.none, fg = mode_color[vim.fn.mode()], gui='bold' }
	end,
}

ins_left {
	'mode',
	icon = '󰕷',
	color = function()
	local mode_color = {
		n = colors.green,
		i = colors.violet,
		v = colors.yellow,
		[''] = colors.yellow,
		V = colors.yellow,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		[''] = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		['r?'] = colors.cyan,
		['!'] = colors.red,
		t = colors.red,
	}
	return { fg = colors.bg, bg = mode_color[vim.fn.mode()], gui='bold' }
	end,
}

ins_left {
	function()
		return ''
	end,
	color = function()
	local mode_color = {
		n = colors.green,
		i = colors.violet,
		v = colors.yellow,
		[''] = colors.yellow,
		V = colors.yellow,
		c = colors.magenta,
		no = colors.red,
		s = colors.orange,
		S = colors.orange,
		[''] = colors.orange,
		ic = colors.yellow,
		R = colors.violet,
		Rv = colors.violet,
		cv = colors.red,
		ce = colors.red,
		r = colors.cyan,
		rm = colors.cyan,
		['r?'] = colors.cyan,
		['!'] = colors.red,
		t = colors.red,
	}
	return { fg = mode_color[vim.fn.mode()], bg = colors.bgdark, gui='bold' }
	end,
	padding = { left = 0, right = 0 }
}

ins_left {
	function()
		mode2 = ""
	 -- if(vim.g.input_toggle == 0) then
	 -- 	mode2 = mode2 .. "汉"
	 -- else
	 -- 	mode2 = mode2 .. "󰌓 "
	 -- end
		if(vim.wo.spell) then
			mode2 = mode2 .. "󰓆 "
		end
		if(vim.wo.wrap) then
			mode2 = mode2 .. "󰖶 "
		end
		return mode2
	end,
	cond = conditions.buffer_not_empty,
	color = { fg = colors.yellow, bg = colors.bgdark, gui = 'bold' },
	padding = { left = 1, right = 0},
}

ins_left {
	'branch',
	icon = '',
	color = { fg = colors.violet, bg = colors.bgdark, gui = 'bold' },
}

ins_left {
	function()
		return ''
	end,
	color = { fg = colors.bgdark, bg = colors.bglight },
	padding = {left = 0 },
}

ins_left {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '󰝤 ', removed = ' ' },
  diff_color = {
	added = { fg = colors.green },
	modified = { fg = colors.orange },
	removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
  color = { bg = colors.bglight },
}

ins_left {
	function()
		return ''
	end,
	color = { fg = colors.bglight },
	padding = { left = 0 },
}

--ins_left {
--	'windows'
--}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
	return '%='
  end,
}

ins_right {
	'filetype',
	cond = conditions.buffer_not_empty,
	color = { fg = colors.magenta, gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = true, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
	function()
		return ''
	end,
	padding = { left = 1, right = 0 },
	color = { fg = colors.bgdark, gui = 'bold' },
	padding = { right = 0},
}

ins_right {
  'diagnostics',
  sources = { 'nvim_diagnostic', 'coc' },
  sections = { 'error', 'warn', 'info', 'hint' },
  symbols = { error = '🤣', warn = '🧐', info = '🫠', hint = '🤔' },
  diagnostics_color = {
	  error = { fg = colors.red },
	  warn = { fg = colors.yellow },
	  info = { fg = colors.cyan },
	  hint = { fg = colors.blue },
	},
	color = { bg = colors.bgdark },
}

ins_right {
	function()
		return ''
	end,
	padding = { left = 0, right = 0 },
	color = { bg = colors.bgdark, fg = colors.green, gui = 'bold' },
}

ins_right {
	'progress',
	icon = {'', align = 'right'},
	color = { fg = colors.bg, bg = colors.green, gui = 'bold' },
}

ins_right {
	'location',
	padding = { left = 0, right = 0 },
	color = { fg = colors.bg, bg = colors.green, gui = 'bold' },
}

ins_right {
  function()
	return ''
  end,
  color = { bg = colors.none, fg = colors.green },
  padding = { left = 0 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
EOF

"-----xtabline----
"let g:xtabline_settings = {}
"let g:xtabline_settings.enable_mappings = 0
"let g:xtabline_settings.tabline_modes = ['tabs','buffers']
"let g:xtabline_settings.enable_persistance = 0
"let g:xtabline_settings.last_open_first = 0
"let g:xtabline_settings.tab_number_in_left_corner = 0
"let g:xtabline_settings.show_right_corner = 1
"let g:xtabline_settings.theme='slate'

"-----bufferline----
lua << EOF
require("bufferline").setup({
	options = {
		mode = "tabs",
		indicator = {
			icon = '▎', -- this should be omitted if indicator style is not 'icon'
			-- style = 'icon' | 'underline' | 'none',
			style = "icon",
		},
		numbers = function(opts)
			local NumberIcon = {
				"❶ ",
				"❷ ",
				"❸ ",
				"❹ ",
				"❺ ",
				"❻ ",
				"❼ ",
				"❽ ",
				"❾ ",
				"❿ ",
			}
			return NumberIcon[tonumber(opts.ordinal)]
		end,
		show_buffer_close_icons = false,
		show_close_icon = false,
		enforce_regular_tabs = true,
		show_duplicate_prefix = false,
		tab_size = 16,
		padding = 0,
		separator_style = "thick",
	}
})
EOF

"----- nvim-scrollbar ---
lua <<EOF
require("scrollbar").setup()
require("scrollbar.handlers.search").setup()
require("scrollbar").setup({
	show = true,
	handle = {
		text = " ",
		color = "#696969",
		hide_if_all_visible = true,
	},
	marks = {
		Search = { color = "yellow" },
		Misc = { color = "purple" },
	},
	handlers = {
		cursor = true,
		diagnostic = true,
		gitsigns = true,
		handle = true,
		search = true,
	},
})
EOF

"----- nvim-hlslens ---
noremap <silent> = <Cmd>execute('normal! ' . v:count1 . 'n')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap <silent> - <Cmd>execute('normal! ' . v:count1 . 'N')<CR>
            \<Cmd>lua require('hlslens').start()<CR>
noremap * *<Cmd>lua require('hlslens').start()<CR>
noremap g* g*<Cmd>lua require('hlslens').start()<CR>
noremap g# g#<Cmd>lua require('hlslens').start()<CR>

"------ barbecue -----
lua require("barbecue").setup()

"smartcolumn
lua require("smartcolumn").setup()

" =====code=====
"-----coc.nvim-----
let g:coc_global_extensions = [
		\ 'coc-clangd',
		\ 'coc-css',
		\ 'coc-ds-pinyin-lsp',
		\ 'coc-flutter',
		\ 'coc-html',
		\ 'coc-json',
		\ 'coc-marketplace',
		\ 'coc-nelua',
		\ 'coc-pyright',
		\ 'coc-snippets',
		\ 'coc-translator',
		\ 'coc-texlab',
		\ 'coc-vimlsp',
		\ 'coc-explorer',
	\ ]
"set helpfile
set nobackup
set nowritebackup
set pumheight=10
set updatetime=100
highlight CocFloating ctermbg=Black
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
inoremap <silent><expr> <c-o> coc#refresh()
nmap <silent> <leader>- <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>= <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <leader>rn <Plug>(coc-rename)
nmap ts <Plug>(coc-translator-p)
let g:coc_snippet_next = '<c-j>'
let g:coc_snippet_prev = '<c-k>'
nmap <F12> :CocCommand explorer<CR>
let g:snips_author = g:User
nnoremap <c-p> :CocCommand ds-pinyin-lsp.toggle-completion<CR>

"-----nerdcommenter-----
let g:NERDCreateDefaultMappings = 0
nmap <leader>cc <Plug>NERDCommenterToggle
vmap <leader>cc <Plug>NERDCommenterToggle

"-----autoformat-----
"call autoformat#config('cpp', 
	"\ ['clang-format -style microsoft -'])
"call autoformat#config('c', 
	"\ ['clang-format -style microsoft -'])
call autoformat#config('html',
    \ ['html-beautify -s 2'])
autocmd! BufWritePre * :Autoformat
nnoremap \f :call AutoFormat()<CR>
func!  AutoFormat()
    if &filetype == "markdown" || &filetype == "vimwiki"
        :TableModeToggle
    else
        :Autoformat
    endif
	exec "w"
endfunction

"---- nvim-colorizer ----
lua << EOF
require 'colorizer'.setup()
--require "colorizer".setup({
--	opts = {
--		filetypes = { "*" },
--		user_default_options = {
--			RGB = true,       -- #RGB hex codes
--			RRGGBB = true,    -- #RRGGBB hex codes
--			names = true,     -- "Name" codes like Blue or blue
--			RRGGBBAA = false, -- #RRGGBBAA hex codes
--			AARRGGBB = true,  -- 0xAARRGGBB hex codes
--			rgb_fn = false,   -- CSS rgb() and rgba() functions
--			hsl_fn = false,   -- CSS hsl() and hsla() functions
--			css = false,      -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
--			css_fn = false,   -- Enable all CSS *functions*: rgb_fn, hsl_fn
--			-- Available modes for `mode`: foreground, background,  virtualtext
--			mode = "virtualtext", -- Set the display mode.
--			-- Available methods are false / true / "normal" / "lsp" / "both"
--			-- True is same as normal
--			tailwind = true,
--			sass = { enable = false },
--			virtualtext = "■",
--		},
--		-- all the sub-options of filetypes apply to buftypes
--		buftypes = {},
--	}
--})
EOF

"----- nvim-lspconfig ----
lua << EOF
local lspconfig = ('nvim-lspconfig')
require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}
EOF

"-----nvim-navbuddy-----
lua << EOF
local navbuddy = require("nvim-navbuddy")
local actions = require("nvim-navbuddy.actions")
navbuddy.setup {
    lsp = {
        auto_attach = true,   -- If set to true, you don't need to manually use attach function
        preference = nil,      -- list of lsp server names in order of preference
    },
}
EOF
nmap \n :Navbuddy<CR>

"---- nvim-treesitter -----
lua <<EOF
require'nvim-treesitter.configs'.setup {
	-- one of "all", "language", or a list of languages
	ensure_installed = {"typescript", "dart",  "c", "cpp", "bash", "go"},
	highlight = {
		enable = true,              -- false will disable the whole extension
		disable = { "rust", "python", "cpp" },  -- list of language that will be disabled
	},
}
EOF

"-----semshi-----
hi semshiLocal           ctermfg=209 guifg=#ff875f
hi semshiGlobal          ctermfg=214 guifg=#ffaf00
hi semshiImported        ctermfg=214 guifg=#ffaf00 cterm=bold gui=bold
hi semshiParameter       ctermfg=75  guifg=#5fafff
hi semshiParameterUnused ctermfg=117 guifg=#87d7ff cterm=underline gui=underline
hi semshiFree            ctermfg=218 guifg=#ffafd7
hi semshiBuiltin         ctermfg=207 guifg=#ff5fff
hi semshiAttribute       ctermfg=49  guifg=#00ffaf
hi semshiSelf            ctermfg=249 guifg=#b2b2b2
hi semshiUnresolved      ctermfg=226 guifg=#ffff00 cterm=underline gui=underline
hi semshiSelected        ctermfg=231 guifg=#EFEFEF ctermbg=161 guibg=#88ABDA

hi semshiErrorSign       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
hi semshiErrorChar       ctermfg=231 guifg=#ffffff ctermbg=160 guibg=#d70000
sign define semshiError text=E> texthl=semshiErrorSign

"-----rainbow-----
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

"----competitest----
lua require('competitest').setup()
autocmd FileType cpp nnoremap <buffer> rr :CompetiTestRun<CR>
autocmd FileType cpp nnoremap <buffer> ra :CompetiTestAdd<CR>
autocmd FileType cpp nnoremap <buffer> re :CompetiTestEdit<CR>
autocmd FileType cpp nnoremap <buffer> ri :CompetiTestReceive testcases<CR>
autocmd FileType cpp nnoremap <buffer> rd :CompetiTestDelete<CR>
"autocmd FileType veil nnoremap <buffer> acm :CompetiTestReceive contest<CR>

"-----markdown-----
autocmd FileType markdown,text set wrap
" disable default key mappings
let g:vim_markdown_no_default_key_mappings = 1
let g:mkdp_browser=g:browser
autocmd FileType markdown let g:mkdp_theme = 'dark'
"tabe
autocmd FileType markdown let g:table_mode_corner='|'
"toc
autocmd FileType markdown nnoremap <buffer> toc :GenTocGitLab<CR>
" images
autocmd FileType markdown nmap <buffer><silent> <leader>p :call mdip#MarkdownClipboardImage()<CR>
autocmd FileType markdown let g:PasteImageFunction = 'g:MarkdownPasteImage'
autocmd FileType tex let g:PasteImageFunction = 'g:LatexPasteImage'
" Bullets
let g:bullets_enabled_file_types = [
    \ 'markdown',
    \ 'text',
    \ 'gitcommit',
    \ 'scratch'
    \]
let g:bullets_outline_levels = ['num']
let g:bullets_set_mappings = 0
let g:bullets_mapping_leader = '<M-b>'
let g:bullets_custom_mappings = [
	\ ['imap', '<cr>', '<Plug>(bullets-newline)'],
	\ ['inoremap', '<C-cr>', '<cr>'],
	\
	\ ['nmap', 'o', '<Plug>(bullets-newline)'],
	\
	\ ['vmap', 'gN', '<Plug>(bullets-renumber)'],
	\ ['nmap', 'gN', '<Plug>(bullets-renumber)'],
	\
	\ ['nmap', '<leader>x', '<Plug>(bullets-toggle-checkbox)'],
	\
	\ ['imap', '<C-=>', '<Plug>(bullets-demote)'],
	\ ['imap', '<C-->', '<Plug>(bullets-promote)'],
	\ ]

"----vimwiki----
let g:vimwiki_list = [{'path': '~/Documents/study/Note/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
autocmd FileType vimwiki set wrap

"-----nvim-autopairs----
lua << EOF
	require("nvim-autopairs").setup({
		map_cr = false,
	})
EOF

"-----telescope.nvim-----
nnoremap <leader>ff :Telescope find_files<CR>
nnoremap <leader>fk :Telescope keymaps<CR>
nnoremap <leader>fb :Telescope buffers<CR>
nnoremap <leader>fg :Telescope grep_string<CR>

"-----gitsigns.nvim-----
lua <<EOF
require('gitsigns').setup({
	signs = {
    add          = { hl = 'GitSignsAdd'   , text = '▎', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
    change       = { hl = 'GitSignsChange', text = '░', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    delete       = { hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    topdelete    = { hl = 'GitSignsDelete', text = '▔', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn' },
    changedelete = { hl = 'GitSignsChange', text = '█', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn' },
    untracked    = { hl = 'GitSignsAdd'   , text = '┆', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'    },
  },
})
EOF
nnoremap <LEADER>gr :Gitsigns reset_hunk<CR>
nnoremap <LEADER>gb :Gitsigns blame_line<CR>
nnoremap <LEADER>g- :Gitsigns prev_hunk<CR>
nnoremap <LEADER>g= :Gitsigns next_hunk<CR>

"---- diffview ----
nnoremap <leader>do :DiffviewOpen<CR>
nnoremap <leader>dc :DiffviewClose<CR>

"-----link-visitor----
lua << EOF
require("link-visitor").setup({
  open_cmd = nil,
  silent = true, -- disable all prints, `false` by defaults skip_confirmation
  skip_confirmation = false, -- Skip the confirmation step, default: false
  border = "rounded" -- none, single, double, rounded, solid, shadow see `:h nvim_open_win()`
})
EOF
nnoremap gl :VisitLinkUnderCursor<CR>

"----rnvimr----
nnoremap <leader>R :RnvimrToggle<CR>

"---- undotree ---
nnoremap L :UndotreeToggle<CR>

"-----vim-easy-align---
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

"-----suda-----
cnoreabbrev sw w suda://%

"-----goyo--------
nnoremap <leader>gy :Goyo<CR>
