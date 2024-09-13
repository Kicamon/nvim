local function space_len(chars)
  return function(len)
    return string.rep(chars, #len)
  end
end

local change_text = coroutine.create(function(pattern, chars)
  while true do
    local total_row = vim.fn.line('$')
    local lines = {}

    for i = 1, total_row, 1 do
      local line = vim.fn.getline(i)
      line = line:gsub(pattern, chars)
      table.insert(lines, line)
    end

    vim.api.nvim_buf_set_lines(0, 0, total_row, false, lines)

    coroutine.yield()
  end
end)

local function tab_to_space()
  vim.schedule(function()
    coroutine.resume(change_text, '^\t+', space_len(string.rep(' ', vim.fn.shiftwidth())))
  end)
end

local function delete_trailing_space()
  vim.schedule(function()
    coroutine.resume(change_text, '%s+$', '')
  end)
end

return {
  tab_to_space = tab_to_space,
  delete_trailing_space = delete_trailing_space,
}
