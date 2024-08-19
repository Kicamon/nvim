"----codeing----
nmap <F5> :call Run()<CR>
func! Run()
	exec "w"
	if &filetype == 'c'
		if filereadable('Makefile')
			:set splitbelow
			:sp
			:res +5
			term make && ./Main
		else
			:set splitbelow
			:sp
			:res +5
			term gcc "%" -o "%<" && "./%<" && rm -f "./%<"
		endif
	elseif &filetype == "cpp"
		if filereadable('Makefile')
			:set splitbelow
			:sp
			:res +5
			term make && ./Main
		else
			:set splitbelow
			:sp
			:res +5
			term g++ "%" -std=c++17 -O2 -g -Wall -o "%<" && "./%<" && rm -f "./%<"
		endif
	elseif &filetype == "python"
		:set splitbelow
		:sp
		:res +5
		term python3 "%"
	elseif &filetype == "lua"
		:set splitbelow
		:sp
		:res +5
		term lua "%"
	elseif &filetype == "dart"
		:set splitbelow
		:sp
		:res +5
		term dart "%"
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	elseif &filetype == 'vimwiki'
		exec "MarkdownPreview"
	elseif &filetype == 'html'
		tabe
		term live-server --browser=chromium
		tabclose
	elseif &filetype == 'tex'
	exec "CocCommand latex.ForwardSearch"
	elseif &filetype == 'sh'
		set splitbelow
		:sp
		:res +5
		term bash "%"
	endif
endfunction

nnoremap rm :call Delete()<CR>
func! Delete()
	if filereadable('Makefile')
		:! make clean
		:lua require("notify")("󰆴 Clearance completed")
	elseif &filetype == "tex"
		:! rm -f "./%<".aux && rm -f "./%<".fdb_latexmk && rm -f "./%<".fls && rm -f "./%<".log && rm -f "./%<".synctex.gz
		:lua require("notify")("󰆴 Clearance completed")
	else
		:! rm -f "./%<" && rm -f "./%<"_*.txt
		:lua require("notify")("󰆴 Test Samples Delete completed")
	endif
endfunction

nmap <leader>mk :call GetMakefile()<CR>
func! GetMakefile()
	if &filetype == "cpp"
		silent :! cp ~/.config/nvim/usr/Makefile/Makefile_cpp ./Makefile
	endif
endfunction

"-----fcitx5-----
let g:input_toggle = 1
function! Fcitx5en()
    let s:input_status = system("fcitx5-remote")
    if s:input_status == 2
        let g:input_toggle = 1
		let l:a = system("fcitx5-remote -c")
    endif
endfunction

function! Fcitx5zh()
        let s:input_status = system("fcitx5-remote")
        if s:input_status != 2 && g:input_toggle == 1
			let l:a = system("fcitx5-remote -o")
            let g:input_toggle = 0
        endif
endfunction
"退出插入模式
autocmd InsertLeave * call Fcitx5en()
"进入插入模式
autocmd InsertEnter *.md,*.txt call Fcitx5zh()
