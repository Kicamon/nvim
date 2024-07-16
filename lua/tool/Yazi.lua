local prev_win = -1
local winnr = -1
local bufnr = -1
local tempname = ''
local workpath = ''

local function OpenFile(open, opt)
  if opt == 'left' then
    vim.cmd('set nosplitright')
  elseif opt == 'down' then
    vim.cmd('set splitbelow')
  elseif opt == 'up' then
    vim.cmd('set nosplitbelow')
  elseif opt == 'right' then
    vim.cmd('set splitright')
  end

  if vim.fn.filereadable(vim.fn.expand(tempname)) == 1 then
    local filenames = vim.fn.readfile(tempname)
    for _, filename in ipairs(filenames) do
      vim.cmd(open .. ' ' .. filename)
    end
  end
end

local function EndOpt()
  vim.fn.delete(tempname)
  vim.cmd('silent! lcd ' .. workpath)
end

local function TabName(name)
  vim.api.nvim_create_autocmd('TermEnter', {
    buffer = bufnr,
    callback = function()
      vim.cmd('set filetype=' .. name)
    end
  })
end

local function CloseFloatWin()
  vim.api.nvim_win_close(winnr, true)
  vim.api.nvim_buf_delete(bufnr, { force = true })
  vim.api.nvim_set_current_win(prev_win)
end

local function Yazi(open, opt)
  prev_win = vim.api.nvim_get_current_win()
  workpath = vim.fn.getcwd()
  local filename = vim.api.nvim_buf_get_name(0)
  vim.cmd('silent! lcd %:p:h')
  local Win = require('tool.util.FloatWin')
  Win:Create({
    width = 0.8,
    height = 0.8,
    title = ' Yazi ',
  })
  WinInfo = Win:GetInfo()
  winnr, bufnr = WinInfo.winnr, WinInfo.bufnr
  TabName('Ranger')
  tempname = vim.fn.tempname()
  vim.fn.termopen(string.format('yazi %s --chooser-file="%s"', filename, tempname), {
    on_exit = function()
      if vim.api.nvim_win_is_valid(winnr) then
        CloseFloatWin()
        OpenFile(open, opt)
      end
      EndOpt()
    end
  })
end


return {
  Yazi = Yazi
}
