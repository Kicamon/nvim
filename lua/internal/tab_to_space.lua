local tts = coroutine.create(function(space)
  while true do
    local lnr = vim.fn.line('$')
    for i = 1, lnr, 1 do
      local line = vim.fn.getline(i)
      line = string.gsub(line, '\t', space)
      vim.fn.setline(i, line)
    end
    coroutine.yield()
  end
end)

local function tab_to_space()
  local sw = vim.fn.shiftwidth()
  local space = string.rep(' ', sw)
  vim.schedule(function()
    coroutine.resume(tts, space)
  end)
end

return tab_to_space()
