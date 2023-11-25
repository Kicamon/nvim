local win = require('user.tool.FloatWin').Create

local function NewTab()
  local bufname = vim.api.nvim_buf_get_name(0)
  vim.cmd(":q!")
  -- vim.cmd(":tabe " .. bufname .. '<CR>')
end

local function Ranger()
  win({
    width = 100,
    height = 30,
    buflisted = true,
    pos = { pos = 'cc' },
    title = ' Ranger ',
  })
  vim.cmd('term ranger')
end

vim.keymap.set('n', 'R', Ranger, {})
vim.keymap.set('n', '<leader>tt', NewTab, {})
