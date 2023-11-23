local TTS = coroutine.create(function(space)
  local lnr = vim.fn.line('$')
  for i = 1, lnr, 1 do
    local line = vim.fn.getline(i)
    line = string.gsub(line, '\t', space)
    vim.fn.setline(i, line)
  end
  coroutine.yield()
end)

local function TabToSpace()
  local sw = vim.fn.shiftwidth()
  local space = ''
  for _ = 1, sw, 1 do
    space = space .. ' '
  end
  vim.schedule(function()
    coroutine.resume(TTS, space)
  end)
end

vim.keymap.set('n', '<leader>ts', TabToSpace, {})
