local pos = {}

local surround_chars = {
  { '(', ')' },
  { '[', ']' },
  { '{', '}' },
  { '<', '>' },
  { '"', '"' },
  { "'", "'" },
}

local function get_surround_char_idx(char)
  for i, v in pairs(surround_chars) do
    if v[1] == char or v[2] == char then
      return i
    end
  end
end

local function find_char_pos(row, col, idx, num)
  local pre = num == 1
  local char, _char = surround_chars[idx][num], surround_chars[idx][3 - num]

  local lens, stack = 0, 0
  local end_line, range = pre and 1 or vim.fn.line('$'), pre and -1 or 1

  for l = row, end_line, range do
    local line = vim.fn.getline(l)
    local start_col = (l == row) and col or (pre and #line or 1)
    local end_col = pre and 1 or #line

    for c = start_col, end_col, range do
      lens = lens + 1
      if line:sub(c, c) == char then
        if stack == 0 then
          return { line_num = l, col_num = c, lens = lens }
        else
          stack = stack - 1
        end
      elseif line:sub(c, c) == _char then
        stack = stack + 1
      end
    end
  end

  return nil
end

---update surround positions
---@param distance integer distance of surround chars, used to ensure that the found location is the cloest
---@param area table {integer:line_from, integer:col_from,integer:line_to,integer:col_to}
---@param idx integer sequence number of surround chars
---@return nil|table {integer:distance, table:charpos}
local function update(distance, area, idx)
  local prev_char_pos = find_char_pos(area[1], area[2], idx, 1)
  local next_char_pos = find_char_pos(area[3], area[4], idx, 2)

  if not prev_char_pos or not next_char_pos then
    return nil
  end

  if
    surround_chars[idx][1] == surround_chars[idx][2]
    and prev_char_pos.line_num ~= next_char_pos.line_num
  then
    return nil
  end

  if distance == -1 or distance > math.min(prev_char_pos.lens, next_char_pos.lens) then
    return {
      distance = math.min(prev_char_pos.lens, next_char_pos.lens),
      charpos = {
        prev_char_pos.line_num,
        prev_char_pos.col_num,
        next_char_pos.line_num,
        next_char_pos.col_num,
      },
    }
  end

  return nil
end

---get visual area
---@return integer line_from
---@return integer col_from
---@return integer line_to
---@return integer col_to
function pos.visual()
  local line_from, col_from, line_to, col_to
  line_from, col_from = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  line_to, col_to = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]

  -- make sure from position befroe to postion
  if line_from > line_to then
    line_from, line_to = line_to, line_from
    col_from, col_to = col_to, col_from
  elseif line_from == line_to and col_from > col_to then
    col_from, col_to = col_to, col_from
  end

  return line_from, col_from, line_to, col_to
end

function pos.get_surround_pos(char)
  local area = { pos.visual() }
  if vim.fn.mode() == 'v' then
    area[2] = area[2] - 2
    area[4] = area[4] + 2
  end

  local charpos = {}
  if char then
    local idx = get_surround_char_idx(char)
    charpos = update(-1, area, idx).charpos
  else
    local distance = -1
    for i = 1, #surround_chars do
      local tmp_val = update(distance, area, i) or { distance = distance, charpos = charpos }
      distance, charpos = tmp_val.distance, tmp_val.charpos
    end
  end

  return charpos
end

return pos
