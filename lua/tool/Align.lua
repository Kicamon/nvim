local specal_chars = { '^', '[', '(', '%', '.' }

local function check_in_table(val, tab)
  for _, v in ipairs(tab) do
    if v == val then
      return true
    end
  end
  return false
end

local function input_chars()
  local chars = vim.fn.input("Align chars: ")
  return chars
end

local function change_lines(sl, el, chars)
  local lines = vim.api.nvim_buf_get_lines(0, sl - 1, el, true)
  local start_pos, max_pos = 1, 0
  while true do
    local position = {}
    local res = 0
    for i = 1, #lines, 1 do
      local pos = string.find(lines[i], chars, start_pos)
      if pos ~= nil then
        table.insert(position, pos)
        res = res + 1
        max_pos = math.max(max_pos, pos)
      else
        table.insert(position, -1)
      end
    end
    start_pos = max_pos + 1
    if res <= 1 then
      break
    end
    for i = 1, #lines, 1 do
      if position[i] ~= -1 then
        local str_start = string.sub(lines[i], 1, position[i] - 1)
        local str_end = string.sub(lines[i], position[i])
        str_end = string.rep(' ', (max_pos - position[i])) .. str_end
        lines[i] = str_start .. str_end
      end
    end
    vim.api.nvim_buf_set_lines(0, sl - 1, el, true, lines)
  end
  vim.cmd('normal! V')
end

local function align()
  local chars = input_chars()
  if chars == '' then
    vim.cmd('normal! V')
    return
  end
  local i, chars_len = 1, #chars
  while i <= chars_len do
    if check_in_table(string.sub(chars, i, i), specal_chars) then
      chars = string.sub(chars, 0, i - 1) .. '%' .. string.sub(chars, i)
      i, chars_len = i + 1, chars_len + 1
    end
    i = i + 1
  end
  local getsurround = require('tool.util.GetSurround')
  local sl, _, el, _ = getsurround.Visual()
  change_lines(sl, el, chars)
end

return {
  align = align
}
