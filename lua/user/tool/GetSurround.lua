local pos = {}

pos.Schar = {
  { '(', ')' },
  { '[', ']' },
  { '{', '}' },
  { '<', '>' },
}

-- local LSchar = {
--   { '"', '"' },
--   { "'", "'" },
-- }

local function find_previous_char(current_line, current_col, charn, num)
  local char, _char = pos.Schar[charn][num], pos.Schar[charn][3 - num]
  local queue, lens = 0, 0
  for l = current_line, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1]
    local start_col = (l == current_line) and current_col or #line
    for c = start_col, 1, -1 do
      lens = lens + 1
      if line:sub(c, c) == char then
        if queue == 0 then
          return { l, c, lens }
        else
          queue = queue - 1
        end
      elseif line:sub(c, c) == _char then
        queue = queue + 1
      end
    end
  end

  return nil
end

local function find_next_char(current_line, current_col, charn, num)
  local char, _char = pos.Schar[charn][num], pos.Schar[charn][3 - num]
  local queue, lens = 0, 0
  for l = current_line, vim.fn.line('$') do
    local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1]
    local start_col = (l == current_line) and current_col or 1
    for c = start_col, #line do
      lens = lens + 1
      if line:sub(c, c) == char then
        if queue == 0 then
          return { l, c, lens }
        else
          queue = queue - 1
        end
      elseif line:sub(c, c) == _char then
        queue = queue + 1
      end
    end
  end

  return nil
end

function pos.Visual()
  local sl, sr, el, er
  sl, sr = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  el, er = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
  if sl > el then
    sl, el = el, sl
    sr, er = er, sr
  elseif sl == el and sr > er then
    sr, er = er, sr
  end
  return { sl, sr, el, er }
end

function pos.GetScharIndex(char)
  for i = 1, #pos.Schar do
    if pos.Schar[i][1] == char or pos.Schar[i][2] == char then
      return i
    end
  end
end

function pos.GetSurround(char)
  local vpos = pos.Visual()
  local sl, sr, el, er = vpos[1], vpos[2], vpos[3], vpos[4]
  local charpos = {}
  if char then
    local index = pos.GetScharIndex(char)
    charpos = {}
    local pp = find_previous_char(sl, sr, index, 1)
    local np = find_next_char(el, er, index, 2)
    if pp ~= nil and np ~= nil then
      charpos = { pp[1], pp[2], np[1], np[2] }
    end
    return charpos
  else
    local dis = -1
    for i = 1, #pos.Schar do
      local pp = find_previous_char(sl, sr, i, 1)
      local np = find_next_char(el, er, i, 2)
      if pp ~= nil and np ~= nil then
        if dis == -1 then
          dis = math.min(pp[3], np[3])
          charpos = { pp[1], pp[2], np[1], np[2] }
        else
          if dis > math.min(pp[3], np[3]) then
            dis = math.min(pp[3], np[3])
            charpos = { pp[1], pp[2], np[1], np[2] }
          end
        end
      end
    end
  end
  return charpos
end

return pos
