local function Ranger()
  local win = require('user.tool.FloatWin').Create
  win({
    width = 0.8,
    height = 0.8,
    buflisted = true,
    pos = { pos = 'cc' },
    title = ' Ranger ',
  })
  vim.cmd('term ranger')
end

vim.keymap.set('n', 'R', Ranger, {})
