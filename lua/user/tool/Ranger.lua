local win = require('user.FloatWin')

local function Ranger()
  win:Create({
    width = 0.8,
    height = 0.8,
    title = ' Ranger ',
  })
  vim.cmd('term ranger')
end

vim.keymap.set('n', 'R', Ranger, {})
