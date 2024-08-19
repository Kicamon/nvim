local function chdir(silent)
  vim.cmd('silent! lcd %:p:h')
  if silent then
    return
  end
  vim.notify('From: ' .. vim.fn.getcwd() .. '\n' .. 'To: ' .. vim.fn.expand('%:p:h'))
end

return { chdir = chdir }
