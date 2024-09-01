local function changemode()
  if vim.fn.mode() == 'v' then
    vim.cmd('normal! v')
  end
end

local function update_position(pos)
  if pos[4] == 1 then
    pos[3] = pos[3] - 1
    pos[4] = #vim.fn.getline(pos[3]) + 1
  end
  return pos
end

local function wildfire()
  local pos = require('internal.util.get_surround').get_surround()
  if not pos or #pos == 0 then
    changemode()
    return
  end
  changemode()
  pos = update_position(pos)
  vim.api.nvim_win_set_cursor(0, { pos[3], pos[4] - 2 })
  vim.cmd('normal! v')
  vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] })
end

return { wildfire = wildfire }
