local api = vim.api
local cursor

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

local wildfire = coroutine.create(function()
  while true do
    local pos = require('internal.util.surround_tools').get_surround_pos()
    if next(pos) then
      -- record cursor position
      if cursor == nil then
        cursor = api.nvim_win_get_cursor(0)
      end
      changemode()
      pos = update_position(pos)
      api.nvim_win_set_cursor(0, { pos[3], pos[4] - 2 })
      vim.cmd('normal! v')
      api.nvim_win_set_cursor(0, { pos[1], pos[2] })
    else
      changemode()
      -- reset cursor position
      if cursor then
        api.nvim_win_set_cursor(0, cursor)
      end
      cursor = nil
    end
    coroutine.yield()
  end
end)

return {
  wildfire = function()
    vim.schedule(function()
      coroutine.resume(wildfire)
    end)
  end,
}
