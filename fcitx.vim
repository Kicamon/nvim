let g:input_toggle = 1
function! Fcitx2en()
	let s:input_status = system("fcitx5-remote")
	if s:input_status == 2
		let g:input_toggle = 1
		let l:a = system("fcitx5-remote -c")
	endif
endfunction

function! Fcitx2zh()
	if expand("%:e")== "md"
		let s:input_status = system("fcitx5-remote")
		if s:input_status != 2 && g:input_toggle == 1
			let l:a = system("fcitx5-remote -o")
			let g:input_toggle = 0
		endif
	endif
endfunction

set ttimeoutlen=150
"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
autocmd InsertEnter * call Fcitx2zh()
