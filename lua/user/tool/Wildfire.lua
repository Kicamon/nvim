local getsurround = require('user.tool.GetSurround')

local function Wildfire()
  local pos = getsurround.GetSurround()
  vim.fn.setpos("'<",{pos[1], pos[2] + 1,0})
  vim.fn.setpos("'>",{pos[3], pos[4] - 1,0})
  vim.fn.visualmode()
end

vim.keymap.set('n','<cr>',Wildfire,{})
