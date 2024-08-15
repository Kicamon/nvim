local pos = {}

pos.surround_char = {
  { '(', ')' },
  { '[', ']' },
  { '{', '}' },
  { '<', '>' },
  { '"', '"' },
  { "'", "'" },
}

local function find_char(current_line, current_col, charn, num, pre)
  local char, _char = pos.surround_char[charn][num], pos.surround_char[charn][3 - num]
  local queue, lens = 0, 0
  local end_line, range = pre and 1 or vim.fn.line('$'), pre and -1 or 1
  for l = current_line, end_line, range do
    local line = vim.api.nvim_buf_get_lines(0, l - 1, l, true)[1]
    local start_col = (l == current_line) and current_col or (pre and #line or 1)
    local end_col = pre and 1 or #line
    for c = start_col, end_col, range do
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

function pos.visual()
  local sl, sr, el, er
  sl, sr = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
  el, er = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
  if sl > el then
    sl, el = el, sl
    sr, er = er, sr
  elseif sl == el and sr > er then
    sr, er = er, sr
  end
  return sl, sr, el, er
end

function pos.get_surround_char_index(char)
  for i = 1, #pos.surround_char do
    if pos.surround_char[i][1] == char or pos.surround_char[i][2] == char then
      return i
    end
  end
end

local function updata(dis, charpos, pp, np, bline)
  if pp ~= nil and np ~= nil then
    if bline and pp[1] ~= np[1] then
      return { dis, charpos }
    elseif dis == -1 then
      dis = math.min(pp[3], np[3])
      charpos = { pp[1], pp[2], np[1], np[2] }
    else
      if dis > math.min(pp[3], np[3]) then
        dis = math.min(pp[3], np[3])
        charpos = { pp[1], pp[2], np[1], np[2] }
      end
    end
  end
  return { dis, charpos }
end

function pos.get_surround(char)
  local sl, sr, el, er = pos.visual()
  if vim.fn.mode() == 'v' then
    sr = sr - 2
    er = er + 2
  end
  local charpos = {}
  if char then
    local index = pos.get_surround_char_index(char)
    charpos = updata(
      -1,
      charpos,
      find_char(sl, sr, index, 1, true),
      find_char(el, er, index, 2, false),
      false
    )[2]
  else
    local dis = -1
    for i = 1, #pos.surround_char do
      local val = updata(
        dis,
        charpos,
        find_char(sl, sr, i, 1, true),
        find_char(el, er, i, 2, false),
        (pos.surround_char[i][1] == '"' or pos.surround_char[i][1] == "'")
      )
      dis, charpos = val[1], val[2]
    end
  end
  return charpos
end

return pos
