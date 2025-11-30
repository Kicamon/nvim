local fn = vim.fn
local jump_key = 'asdfghjkl;'

---get char
---@return boolean
---@return string
local function getchar()
  local ok, char = pcall(fn.getcharstr)
  return ok and char ~= '\x1b', char
end

---get jump key
---@param num number
---@return string
local function get_jump_key(num)
  if num == 0 then
    num = 10
  end
  return jump_key:sub(num, num)
end

local function jump()
  local row_from, row_to = fn.line('w0'), fn.line('w$')
  local ok, num_t, num_o
  ok, num_t = getchar()
  if not ok then
    return
  end
  ok, num_o = getchar()
  if not ok then
    return
  end

  for i = row_from, row_to do
    if
      get_jump_key(math.fmod(math.floor(i / 10), 10)) == num_t
      and get_jump_key(math.fmod(i, 10)) == num_o
    then
      vim.cmd('normal ' .. i .. 'G')
    end
  end
end

return { jump = jump }
