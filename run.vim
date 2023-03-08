map  <F5>  :w<CR>:call Run()<CR>
imap <F5>  <ESC>:w<CR>:call Run()<CR>
func! Run()
	if &filetype == 'c'
		:sp
		:res 100
		term gcc % -o %< && ./%< && rm -f ./%<
	elseif &filetype == "cpp"
		:sp
		:res 100
		term g++ % -std=c++17 -O2 -g -Wall -o %< && ./%< && rm -f ./%<
	elseif &filetype == 'markdown'
		exec "MarkdownPreview"
	endif
endfunction
