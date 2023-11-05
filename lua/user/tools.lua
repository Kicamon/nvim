----- code running ----
local function split()
  local winsel = vim.fn.win_getid()
  local winhei = vim.fn.winheight(winsel)
  local winwid = vim.fn.winwidth(winsel)
  if winhei * 2.5 > winwid then
    vim.o.splitbelow = true
    vim.cmd('split')
    vim.cmd('resize-5')
  else
    vim.o.splitright = true
    vim.cmd('vsplit')
    vim.cmd('vertical resize-20')
  end
end

local function Run()
  vim.cmd('w')
  if (vim.bo.filetype == 'c') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      vim.cmd('term gcc "%" -o "%<" && "./%<" && rm -f "./%<"')
    end
  elseif (vim.bo.filetype == 'cpp') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      vim.cmd('term g++ "%" -std=c++17 -O2 -g -Wall -o "%<" && "./%<" && rm -f "./%<"')
    end
  elseif (vim.bo.filetype == 'python') then
    split()
    vim.cmd('term python3 "%"')
  elseif (vim.bo.filetype == 'lua') then
    split()
    vim.cmd('term lua "%"')
  elseif (vim.bo.filetype == 'markdown') then
    vim.cmd('MarkdownPreview')
  elseif (vim.bo.filetype == 'sh') then
    split()
    vim.cmd('term bash "%"')
  elseif (vim.bo.filetype == 'html') then
    vim.cmd([[
      tabe
      term live-server --browser=chromium
      tabclose
    ]])
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
  end
end

vim.keymap.set('n', '<F5>', Run, { noremap = true })

------ getmakefile -----
local function GetMakefile()
  if (vim.bo.filetype == 'cpp') then
    vim.cmd('silent ! cp ~/.config/nvim/lua/user/Makefiles/Makefile_cpp ./Makefile')
  end
end

vim.keymap.set('n', '<leader>mk', GetMakefile, { noremap = true })

------ clear ------
local function Clear()
  if (vim.fn.filereadable('Makefile') == 1) then
    vim.cmd('silent ! make clean')
  else
    vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_*.txt')
  end
  vim.notify("󰆴 Clearn")
end

vim.keymap.set('n', 'rm', Clear, { noremap = true })

------ TabToSpace ------
local function TabToSpace()
  local sw = vim.fn.shiftwidth()
  local space = ''
  for _ = 1, sw, 1 do
    space = space .. ' '
  end
  local bool = vim.fn.search('\\t', 'n')
  if bool ~= 0 then
    vim.cmd("execute ':%s/\\t/" .. space .. "/g'")
    vim.api.nvim_input('<C-O>')
  end
end

vim.keymap.set('n', '<leader>ts', TabToSpace, { noremap = true })
