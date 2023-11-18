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
      term live-server --browser=wyeb
      tabclose
    ]])
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, true, true), 'n', true)
  end
end

vim.keymap.set('n', '<F5>', Run, {})

------ getmakefile -----
local function GetMakefile()
  if (vim.bo.filetype == 'cpp') then
    vim.cmd('silent ! cp ~/.config/nvim/lua/user/Makefiles/Makefile_cpp ./Makefile')
  end
end

vim.keymap.set('n', '<leader>mk', GetMakefile, {})

------ clear ------
local function Clear()
  if (vim.fn.filereadable('Makefile') == 1) then
    vim.cmd('silent ! make clean')
  else
    vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_*.txt')
  end
  vim.notify("󰆴 Clearn")
end

vim.keymap.set('n', 'rm', Clear, {})

------ GetNode------
local function GetNode()
  local node_cursor = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  while node_cursor do
    vim.notify(node_cursor:type())
    node_cursor = node_cursor:parent()
  end
  return true
end
vim.keymap.set("n", "<leader>P", GetNode, {})

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

vim.keymap.set('n', '<leader>ts', TabToSpace, {})

------ Wiki ------
local function OpenWiki()
  local path = "~/Documents/study/Note/wiki/"
  if vim.fn.filereadable(vim.fn.expand(path .. 'index.md')) == 0 then
    vim.cmd("silent !mkdir -p " .. path)
    vim.cmd("silent !touch " .. path .. "index.md")
  end
  local open = vim.api.nvim_buf_get_name(0) == '' and 'e ' or 'tabe '
  vim.cmd(open .. path .. "index.md")
end

vim.keymap.set('n', '<leader>ww', OpenWiki, {})

local function Create_Open()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if node then
    if node:type() == "link_text" or node:type() == "link_destination" then
      local line = vim.api.nvim_get_current_line()
      local pattern = "[^.]+([^)]+)"
      local path = string.match(line, pattern)
      vim.cmd(":tabe " .. path)
    elseif node:type() == "inline" then
      local ln, tl, tr = vim.fn.line('.'), vim.fn.getpos('v')[3], vim.fn.getpos('.')[3]
      local line = vim.fn.getline(ln)
      local file_name = string.sub(line, tl, tr)
      local fine_link = './' .. string.gsub(file_name, " ", "_") .. '.md'
      local line_front = tl == 1 and '' or string.sub(line, 1, tl - 1)
      local line_end = tr == #line and '' or string.sub(line, tr + 1)
      local line_mid = '[' .. file_name .. '](' .. fine_link .. ')'
      vim.fn.setline(ln, line_front .. line_mid .. line_end)
      vim.api.nvim_input('<ESC>')
    end
  else
    return
  end
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = "*.md",
  callback = function()
    vim.keymap.set({ 'n', 'v' }, '<CR>', Create_Open, { buffer = true })
  end
})

------ Surround ------
local function Add_Surround(line, char)
  if char == "'" or char == '"' then
    line[1] = char .. line[1]
    line[#line] = line[#line] .. char
  elseif char == '(' or char == ')' then
    line[1] = '(' .. line[1]
    line[#line] = line[#line] .. ')'
  elseif char == '[' or char == ']' then
    line[1] = '[' .. line[1]
    line[#line] = line[#line] .. ']'
  elseif char == '{' or char == '}' then
    line[1] = '{' .. line[1]
    line[#line] = line[#line] .. '}'
  elseif char == '<' or char == '>' then
    line[1] = '<' .. line[1]
    line[#line] = line[#line] .. '>'
  else
    line[1] = char .. line[1]
    line[#line] = line[#line] .. char
  end
  return line
end

local function Surround()
  local ok, char = pcall(vim.fn.getcharstr)
  if not ok or char == '^[' then
    return
  end
  local sl, sr = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  local el, er = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
  if sl > el then
    sl, el = el, sl
    sr, er = er, sr
  elseif sl == el and sr > er then
    sr, er = er, sr
  end
  if vim.fn.mode() == 'V' then
    sr, er = vim.fn.indent(sl) + 1, string.len(vim.fn.getline(el))
  end
  if sl == el then
    local line = vim.fn.getline(sl)
    local line_mid = string.sub(line, sr, er)
    local L = Add_Surround({ line_mid }, char)
    line_mid = L[1]
    local line_front = sr == 1 and '' or string.sub(line, 1, sr - 1)
    local line_end = er == #line and '' or string.sub(line, er + 1)
    vim.fn.setline(sl, line_front .. line_mid .. line_end)
  else
    local lines, linee = vim.fn.getline(sl), vim.fn.getline(el)
    local lines_mid, linee_mid = string.sub(lines, sr), string.sub(linee, 1, er)
    local line = Add_Surround({ lines_mid, linee_mid }, char)
    lines_mid, linee_mid = line[1], line[#line]
    local line_front = sr == 1 and '' or string.sub(lines, 1, sr - 1)
    local line_end = er == #linee and '' or string.sub(linee, er + 1)
    vim.fn.setline(sl, line_front .. lines_mid)
    vim.fn.setline(el, linee_mid .. line_end)
  end
  vim.api.nvim_input('<ESC>')
end

vim.keymap.set('v', 'S', Surround, { noremap = true })

