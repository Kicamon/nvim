------ fcitx5 ------
local input_toggle = 1

function Fcitx5en()
	local input_status = tonumber(io.popen("fcitx5-remote"):read("*all"))
	if (input_status == 2) then
		input_toggle = 1
		os.execute("fcitx5-remote -c")
	end
end

function Fcitx5zh()
	local input_status = tonumber(io.popen("fcitx5-remote"):read("*all"))
	if (input_status ~= 2 and input_toggle == 1) then
		os.execute("fcitx5-remote -o")
		input_toggle = 0
	end
end

vim.api.nvim_create_autocmd("InsertLeave", { pattern = "*", command = "lua Fcitx5en()" })
vim.api.nvim_create_autocmd("InsertEnter", { pattern = { "*.md", "*.txt" }, command = "lua Fcitx5zh()" })


----- codeing ----
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
	elseif (vim.bo.filetype == 'dart') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term dart "%"')
	elseif (vim.bo.filetype == 'markdown') then
		vim.cmd('MarkdownPreview')
	elseif (vim.bo.filetype == 'vimwiki') then
		vim.cmd('MarkdownPreview')
	elseif (vim.bo.filetype == 'sh') then
		vim.o.splitbelow = true
		vim.cmd('sp')
		vim.cmd('term bash "%"')
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
