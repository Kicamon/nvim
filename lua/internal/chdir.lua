local function chdir()
  local dir = vim.fn.getcwd()
  vim.cmd('silent! lcd %:p:h')
  vim.notify(
    'From: ' .. dir .. '\n' .. 'To: ' .. vim.fn.expand('%:p:h'),
    1000
  )
end

return { chdir = chdir }
