----- code running ----
function Run()
	vim.cmd('w')
	if (vim.bo.filetype == 'c') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		if (vim.fn.filereadable('Makefile') == 1) then
			vim.cmd('term make && ./Main')
		else
			vim.cmd('term gcc "%" -o "%<" && "./%<" && rm -f "./%<"')
		end
	elseif (vim.bo.filetype == 'cpp') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		if (vim.fn.filereadable('Makefile') == 1) then
			vim.cmd('term make && ./Main')
		else
			vim.cmd('term g++ "%" -std=c++17 -O2 -g -Wall -o "%<" && "./%<" && rm -f "./%<"')
		end
	elseif (vim.bo.filetype == 'python') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term python3 "%"')
	elseif (vim.bo.filetype == 'lua') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term lua "%"')
	elseif (vim.bo.filetype == 'markdown' or vim.bo.filetype == 'vimwiki') then
		vim.cmd('MarkdownPreview')
	elseif (vim.bo.filetype == 'sh') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term bash "%"')
	elseif (vim.bo.filetype == 'html') then
		vim.cmd([[
			tabe
			term live-server --browser=chromium
			tabclose
		]])
	end
end

vim.keymap.set('n', '<F5>', ':lua Run()<CR>', { noremap = true })

------ getmakefile -----
function GetMakefile()
	if (vim.bo.filetype == 'cpp') then
		vim.cmd('silent ! cp ~/.config/nvim/lua/user/Makefiles/Makefile_cpp ./Makefile')
	end
end

vim.keymap.set('n', '<leader>mk', ':lua GetMakefile()<CR>', { noremap = true })

------ clear ------
function Clear()
	if (vim.fn.filereadable('Makefile') == 1) then
		vim.cmd('silent ! make clean')
	else
		vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_*.txt')
	end
end

vim.keymap.set('n', 'rm', ':lua Clear()<CR>', { noremap = true })
