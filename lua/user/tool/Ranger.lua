local prev_win = -1
local winnr = -1
local bufnr = -1
local tempname = ''
local TL = require('user.TabList')

local function OpenFile(open)
  local tab_opend = {}
  if open == 'vsplit' then
    vim.cmd(':set splitright')
  else
    tab_opend = TL:TabList()
  end

  if vim.fn.filereadable(vim.fn.expand(tempname)) == 1 then
    local filenames = vim.fn.readfile(tempname)
    for _, filename in ipairs(filenames) do
      local index = TL:TabOpend(filename, tab_opend)
      if index ~= 0 then
        vim.cmd(index .. 'tabnext')
      else
        vim.cmd(open .. ' ' .. filename)
      end
    end
  end
end

local function CleanUp()
  vim.fn.delete(tempname)
end

local function TabName(name)
  vim.api.nvim_create_autocmd('TermEnter', {
    buffer = bufnr,
    callback = function()
      vim.api.nvim_command('file ' .. name)
    end
  })
end

local function CloseFloatWin()
  vim.api.nvim_win_close(winnr, true)
  vim.api.nvim_buf_delete(bufnr, { force = true })
  vim.api.nvim_set_current_win(prev_win)
end

local function Ranger(open)
  prev_win = vim.api.nvim_get_current_win()
  local Win = require('user.FloatWin')
  Win:Create({
    width = 0.8,
    height = 0.8,
    title = ' Ranger ',
  })
  WinInfo = Win:GetInfo()
  winnr, bufnr = WinInfo.winnr, WinInfo.bufnr
  TabName('Ranger')
  tempname = vim.fn.tempname()
  vim.fn.termopen(string.format('ranger --choosefiles="%s"', tempname), {
    on_exit = function()
      if vim.api.nvim_win_is_valid(winnr) then
        CloseFloatWin()
        OpenFile(open)
      end
      CleanUp()
    end
  })
end

vim.keymap.set('n', '<leader>ra', function() Ranger('tabedit') end, {})
vim.keymap.set('n', '<leader>rl', function() Ranger('vsplit') end, {})
