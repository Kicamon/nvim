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
    if #pos == 0 then
      changemode()
    else
      changemode()
      pos = update_position(pos)
      vim.api.nvim_win_set_cursor(0, { pos[3], pos[4] - 2 })
      vim.cmd('normal! v')
      vim.api.nvim_win_set_cursor(0, { pos[1], pos[2] })
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
