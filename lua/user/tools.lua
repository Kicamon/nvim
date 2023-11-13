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
    vim.cmd("! touch " .. path .. "index.md")
  end
  vim.cmd("e " .. path .. "index.md")
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
      local s_l, s_r = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
      local e_l, e_r = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
      local file_name = vim.fn.getline(s_l, e_l)
      file_name[1] = string.sub(file_name[1], s_r)
      file_name[#file_name] = string.sub(file_name[#file_name], 1, e_r)
      local file_text = table.concat(file_name, "")
      local file_link = string.gsub(file_text, " ", "_") .. '.md'
      vim.api.nvim_input('c' .. '[' .. file_text .. '](./' .. file_link .. ')<esc>:tabe ' .. file_link .. '<CR>')
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
