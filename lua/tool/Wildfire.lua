local function changemode()
  if vim.fn.mode() == 'v' then
    vim.cmd('normal! v')
  end
end

local function checkpos(pos)
  if #vim.fn.getline(pos[1]) == pos[2] then
    pos[1] = pos[1] + 1
    pos[2] = 0
  end
  if pos[4] == 1 then
    pos[3] = pos[3] - 1
    pos[4] = #vim.fn.getline(pos[3]) + 1
  end
  return pos
end

local function Wildfire()
  local getsurround = require('tool.util.GetSurround')
  local pos = getsurround.GetSurround()
  if not pos or #pos == 0 then
    changemode()
    return
  end
  changemode()
  pos = checkpos(pos)
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] })
  vim.cmd('normal! v')
  vim.api.nvim_win_set_cursor(0, { pos[3], pos[4] - 2 })
end

return {
  Wildfire = Wildfire
}

