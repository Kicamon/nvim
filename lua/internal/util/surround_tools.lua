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
  local end_row, range = pre and 1 or vim.fn.line('$'), pre and -1 or 1

  for l = row, end_row, range do
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
---@param area table {integer:row_from, integer:col_from,integer:row_to,integer:col_to}
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

---init search's start positions
---@param area table { integer:row_from, integer:col_from, integer:row_to, integer:col_to }
---@return table { integer:row_from, integer:col_from, integer:row_to, integer:col_to }
local function init_area(area)
  local mode = vim.fn.mode()
  if mode == 'v' then -- if in visual mode, skip the current surround
    area[2] = area[2] - 2
    area[4] = area[4] + 2
  elseif mode == 'n' then -- if in normal mode, check the char under cursor, if is surround chars, skip it
    local line = vim.api.nvim_get_current_line()
    local col = area[2]
    local cursor_char = line:sub(col, col)
    local cursor_char_prev = col > 1 and line:sub(col - 1, col - 1)
    local cursor_char_next = col < #line and line:sub(col + 1, col + 1)
    for _, val in ipairs(surround_chars) do
      if cursor_char == val[1] and cursor_char_next == val[2] then
        area[2] = area[2] - 1
        area[4] = area[4] + 2
      elseif cursor_char == val[2] and cursor_char_prev == val[1] then
        area[2] = area[2] - 2
        area[4] = area[4] + 1
      elseif cursor_char == val[1] or cursor_char == val[2] then
        area[2] = area[2] - 1
        area[4] = area[4] + 1
      end
    end
  end

  return area
end

---get visual area
---@return integer row_from
---@return integer col_from
---@return integer row_to
---@return integer col_to
function pos.visual()
  local row_from, col_from, row_to, col_to
  row_from, col_from = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  row_to, col_to = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]

  -- make sure from position befroe to postion
  if row_from > row_to then
    row_from, row_to = row_to, row_from
    col_from, col_to = col_to, col_from
  elseif row_from == row_to and col_from > col_to then
    col_from, col_to = col_to, col_from
  end

  return row_from, col_from, row_to, col_to
end

function pos.get_surround_pos(char)
  local area = { pos.visual() }
  area = init_area(area)

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
