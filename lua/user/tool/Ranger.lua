local win = require('user.tool.FloatWin').Create

local function Tree()
  win({
    width = 100,
    height = 30,
    buflisted = true,
    pos = { pos = 'cc' },
    title = ' Ranger ',
  })
  vim.cmd('term ranger')
end

vim.keymap.set('n', 'R', Tree, {})
