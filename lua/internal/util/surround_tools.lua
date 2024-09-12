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

local function find_char_pos(start_line, col, idx, num)
  local pre = num == 1
  local char, _char = surround_chars[idx][num], surround_chars[idx][3 - num]

  local lens, stack = 0, 0
  local end_line, range = pre and 1 or vim.fn.line('$'), pre and -1 or 1

  for l = start_line, end_line, range do
    local line = vim.fn.getline(l)
    local start_col = (l == start_line) and col or (pre and #line or 1)
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

local function update(dis, charpos, prev_char_pos, next_char_pos, dis_cross_bank)
  if not prev_char_pos or not next_char_pos then
    return { dis = dis, charpos = charpos }
  end

  if dis_cross_bank and prev_char_pos.line_num ~= next_char_pos.line_num then
    return { dis = dis, charpos = charpos }
  end

  if dis == -1 or dis > math.min(prev_char_pos.lens, next_char_pos.lens) then
    dis = math.min(prev_char_pos.lens, next_char_pos.lens)
    charpos = {
      prev_char_pos.line_num,
      prev_char_pos.col_num,
      next_char_pos.line_num,
      next_char_pos.col_num,
    }
  end

  return { dis = dis, charpos = charpos }
end

function pos.visual()
  local sl, sc, el, ec
  sl, sc = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  el, ec = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
  if sl > el then
    sl, el = el, sl
    sc, ec = ec, sc
  elseif sl == el and sc > ec then
    sc, ec = ec, sc
  end
  return sl, sc, el, ec
end

function pos.get_surround_pos(char)
  local sl, sc, el, ec = pos.visual()
  if vim.fn.mode() == 'v' then
    sc = sc - 2
    ec = ec + 2
  end

  local charpos = {}
  if char then
    local idx = get_surround_char_idx(char)
    charpos = update(
      -1,
      charpos,
      find_char_pos(sl, sc, idx, 1),
      find_char_pos(el, ec, idx, 2),
      false
    ).charpos
  else
    local dis = -1
    for i = 1, #surround_chars do
      local tmp_val =
        update(dis, charpos, find_char_pos(sl, sc, i, 1), find_char_pos(el, ec, i, 2), (i > 3))
      dis, charpos = tmp_val.dis, tmp_val.charpos
    end
  end

  return charpos
end

return pos
