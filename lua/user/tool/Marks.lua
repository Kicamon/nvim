-- todo:
-- list
-- open

local path = vim.g.mark_path
local marks = {}
local tab_opend = {}
local TL = require('user.TabList')

local function ToTable(str)
  local tab = {}
  for match in str:gmatch("'(.-)'") do
    table.insert(tab, match)
  end
  return tab
end

local function ToString(tab)
  local str = ''
  for i, v in ipairs(tab) do
    str = str .. "'" .. v .. "'"
    if i ~= #tab then
      str = str .. ' '
    end
  end
  return str
end

local function MarkName()
  local mark_name = vim.fn.input('Mark Name: ')
  return mark_name
end

local function NewMarkInfo(mark_name)
  if mark_name == nil then
    mark_name = MarkName()
  end
  local filename = vim.api.nvim_buf_get_name(0)
  local pos = vim.api.nvim_win_get_cursor(0)
  local mark_info = { mark_name, filename, pos[1], pos[2] }
  return mark_info
end

local function GetMarkInfo(title)
  for i = 1, #marks do
    if marks[i][1] == title then
      return marks[i]
    end
  end
end

local function GetMarkIndex(mark_name)
  for i = 1, #marks do
    if marks[i][1] == mark_name then
      return i
    end
  end
  return 0
end

local function GetMarkTitle()
  local title = {}
  for i = 1, #marks do
    table.insert(title, marks[i][1])
  end
  return title
end

local function Check(mark)
  for i = 1, #marks do
    if marks[i][1] == mark[1] then
      return i
    end
  end
  return #marks + 1
end

local function ReadMark()
  if vim.fn.filereadable(path) == 0 then
    vim.cmd('!touch ' .. path)
  end
  marks = vim.fn.readfile(path)
  for i = 1, #marks do
    marks[i] = ToTable(marks[i])
  end
end

local function WriteMark()
  local tab = ''
  for i = 1, #marks do
    tab = tab .. ToString(marks[i]) .. '\n'
  end
  local file = io.open(path, 'w')
  if file ~= nil then
    file:write(tab)
    file:close()
  end
  ReadMark()
end

local function OpenFile(mark, open)
  tab_opend = TL:TabList()
  local index = TL:TabOpend(mark[2], tab_opend)
  if open == 'vsplit' then
    vim.cmd('set splitright')
    vim.cmd('vsplit ' .. mark[2])
  elseif index ~= 0 then
    vim.cmd(index .. 'tabnext')
  else
    vim.cmd('tabedit ' .. mark[2])
  end
  vim.api.nvim_win_set_cursor(0, { tonumber(mark[3]), tonumber(mark[4]) })
end

local function CloseWin(winnr)
  for _, v in ipairs(winnr) do
    vim.api.nvim_win_close(v, true)
  end
end

local function Preview(mark, winnr)
  local Win = require('user.FloatWin')
  if winnr == 0 then
    local ui = vim.api.nvim_list_uis()[1]
    Win:Create({
      anchor = 'SW',
      width = 0.66,
      height = 0.3,
      title = mark[2],
    }, {
      pos = {
        ui.height,
        ui.width * 2 / 3,
      }
    })
  end
  vim.api.nvim_set_current_win(winnr)
  local info = Win:GetInfo()
  vim.cmd('edit ' .. mark[2])
  vim.api.nvim_win_set_cursor(0, { tonumber(mark[3]), tonumber(mark[4]) })
  vim.keymap.set('n', '<c-c>j', function()
    CloseWin({ info.winnr })
    OpenFile(mark)
  end, { buffer = true })
  return info.winnr
end

local function Delete(index)
  table.remove(marks, index)
end

local function List()
  local ui = vim.api.nvim_list_uis()[1]
  local Win = require('user.FloatWin')
  Win:Create({
    anchor = 'SW',
    width = 0.31,
    height = 0.3,
    title = 'Marks',
  }, {
    pos = {
      ui.height,
      0,
    }
  })
  local info = Win:GetInfo()
  local mark_title = GetMarkTitle()
  vim.api.nvim_buf_set_lines(info.bufnr, 0, -1, false, mark_title)
  local winnr = Preview(marks[1], 0)
  vim.api.nvim_set_current_win(info.winnr)
  vim.keymap.set('n', 'Q', function() CloseWin({ winnr, info.winnr }) end, { buffer = true })
  vim.keymap.set('n', '<cr>', function()
    local lnum = vim.fn.line('.')
    OpenFile(marks[lnum])
    CloseWin({ winnr, info.winnr })
  end, { buffer = true })
  vim.keymap.set('n', 'l', function()
    local lnum = vim.fn.line('.')
    OpenFile(marks[lnum], 'vsplit')
    CloseWin({ winnr, info.winnr })
  end, { buffer = true })
  vim.api.nvim_create_autocmd('CursorMoved', {
    buffer = info.bufnr,
    callback = function()
      local lnum = vim.fn.line('.')
      Preview(marks[lnum], winnr)
      vim.api.nvim_set_current_win(info.winnr)
    end
  })
end

local function BookMark(opt)
  ReadMark()
  if opt == 'set' then
    local mark_info    = NewMarkInfo()
    local check_marks  = Check(mark_info)
    marks[check_marks] = mark_info
    WriteMark()
  elseif opt == 'open' then
    local mark_name = MarkName()
    local mark_info = GetMarkInfo(mark_name)
    OpenFile(mark_info)
  elseif opt == 'preview' then
    local mark_name = MarkName()
    local mark_info = GetMarkInfo(mark_name)
    Preview(mark_info, 0)
  elseif opt == 'delete' then
    local mark_name = MarkName()
    local index     = GetMarkIndex(mark_name)
    if index ~= 0 then
      Delete(index)
      WriteMark()
      ReadMark()
    end
  elseif opt == 'list' then
    List()
  end
end

vim.api.nvim_create_user_command(
  'Mark',
  function(opt)
    BookMark(opt.args)
  end,
  { nargs = '?' }
)
