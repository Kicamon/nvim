local function chdir()
  vim.cmd('silent! lcd %:p:h')
  vim.notify('From: ' .. vim.fn.getcwd() .. '\n' .. 'To: ' .. vim.fn.expand('%:p:h'))
end

return { chdir = chdir }
