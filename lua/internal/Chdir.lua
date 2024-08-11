local function chdir()
  local dir = vim.fn.getcwd()
  vim.cmd('silent! lcd %:p:h')
  vim.notify(
    '\nFrom: ' .. dir .. '\n' .. 'To: ' .. vim.fn.expand('%:p:h'),
    1000,
    { title = 'Change directory', icon = '' }
  )
end

return {
  chdir = chdir,
}
