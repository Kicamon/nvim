local prev_win = -1
local winnr = -1
local bufnr = -1
local tempname = ''

local function OpenFile()
  if vim.fn.filereadable(vim.fn.expand(tempname)) == 1 then
    local filename = vim.fn.readfile(tempname)[1]
    filename = vim.fn.fnamemodify(filename, ':p:~:')
    vim.cmd(':tabe ' .. filename)
    local filetype = filename:match("%.([%a%d]+)$")
    if filetype ~= nil then
      vim.cmd(':set filetype=' .. filetype)
    end
  end
end

local function OpenRanger()
  prev_win = vim.api.nvim_get_current_win()
  local Win = require('user.FloatWin')
  Win:Create({
    width = 0.8,
    height = 0.8,
    title = ' Ranger ',
  })
  WinInfo = Win:GetInfo()
  winnr, bufnr = WinInfo.winnr, WinInfo.bufnr
  tempname = vim.fn.tempname()
  vim.fn.termopen('ranger --choosefile="' .. tempname .. '"')
  vim.api.nvim_command('file Ranger')
end

local function Ranger()
  OpenRanger()
  vim.api.nvim_create_autocmd('TermClose', {
    callback = function()
      if vim.api.nvim_win_is_valid(winnr) then
        vim.api.nvim_win_close(winnr, true)
        vim.api.nvim_buf_delete(bufnr, { force = true })
        vim.api.nvim_set_current_win(prev_win)
        OpenFile()
      end
    end
  })
end

vim.keymap.set('n', 'R', Ranger, {})
