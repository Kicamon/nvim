local api = vim.api
local getsurround = require('internal.util.surround_tools')

local function feedkeys(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local keys = {
  ['('] = { left = '(', right = ')' },
  ['['] = { left = '[', right = ']' },
  ['{'] = { left = '{', right = '}' },
  ['<'] = { left = '<', right = '>' },

  [')'] = { left = '( ', right = ' )' },
  [']'] = { left = '[ ', right = ' ]' },
  ['}'] = { left = '{ ', right = ' }' },
  ['>'] = { left = '< ', right = ' >' },
}

---get surround char
---@return table {ok: boolen, char: string}
local function getchar()
  local ok, char = pcall(vim.fn.getcharstr)
  if char == '\x1b' then
    ok = false
  end
  return { ok, char }
end

---check if have zh
---@param lnum integer
---@param cnum integer
---@return boolean
local function check_zh(lnum, cnum)
  return (vim.fn.getline(lnum):sub(cnum):find('[\227-\233\128-\191]') == 1)
end

---change text inline
---@param pos table
---@param chars1 string
---@param chars2 string
local function change_line(pos, chars1, chars2)
  api.nvim_buf_set_text(0, pos[3] - 1, pos[4] - 1, pos[3] - 1, pos[4], { chars2 })
  api.nvim_buf_set_text(0, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2], { chars1 })
end

---add surround chars
local function add_surround()
  local Char = getchar()
  -- if no char are inputed or char is <esc>, return
  if not Char[1] then
    feedkeys('<ESC>', 'n')
    return
  end

  local char = Char[2]
  local row_from, col_frome, row_to, col_to = getsurround.visual() -- get visual pos
  -- if mode is visual line, update start and end row's pos
  if vim.fn.mode() == 'V' then
    col_frome, col_to = vim.fn.indent(row_from) + 1, vim.fn.getline(row_to):len()
  end
  -- if is ends in zh, move the endrow back by 2
  if check_zh(row_to, col_to) then
    col_to = col_to + 2
  end

  -- add pair to the selection
  local left, right = char, char
  if keys[char] then
    left = keys[char].left
    right = keys[char].right
  end
  local lines = api.nvim_buf_get_text(0, row_from - 1, col_frome - 1, row_to - 1, col_to, {})
  lines[1] = left .. lines[1]
  lines[#lines] = lines[#lines] .. right
  api.nvim_buf_set_text(0, row_from - 1, col_frome - 1, row_to - 1, col_to, lines)

  feedkeys('<ESC>', 'n')
end

---remove surround chars
local function remove_surround()
  local Char = getchar()
  if not Char[1] then
    return
  end

  local pos = getsurround.get_surround_pos(Char[2])
  change_line(pos, '', '')
end

---change surround chars
local function change_surround()
  -- enter the char to be replaced
  local char = getchar()
  -- if no char are inputed or char is <esc>, return
  if not char[1] then
    return
  end

  local char_odd = char[2]
  -- enter the char to replace
  char = getchar()
  if not char[1] then
    return
  end

  local char_new = keys[char[2]]
  local pos = getsurround.get_surround_pos(char_odd)
  change_line(pos, char_new.left, char_new.right)
end

return {
  add_surround = add_surround,
  change_surround = change_surround,
  remove_surround = remove_surround,
}
