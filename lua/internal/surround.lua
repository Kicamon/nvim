local getsurround = require('internal.util.surround_tools')

local function feedkeys(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local keys = {
  ['('] = { st = '(', ed = ')' },
  ['['] = { st = '[', ed = ']' },
  ['{'] = { st = '{', ed = '}' },
  ['<'] = { st = '<', ed = '>' },

  [')'] = { st = '( ', ed = ' )' },
  [']'] = { st = '[ ', ed = ' ]' },
  ['}'] = { st = '{ ', ed = ' }' },
  ['>'] = { st = '< ', ed = ' >' },

  ['"'] = { st = '"', ed = '"' },
  ["'"] = { st = "'", ed = "'" },
  ['`'] = { st = '`', ed = '`' },
}

---add chars to lines
---@param lines table
---@param char string
---@return table
local function add_surround_chars_to_lines(lines, char)
  local st = keys[char] and keys[char].st or char
  local ed = keys[char] and keys[char].ed or char
  lines[1] = st .. lines[1]
  lines[#lines] = lines[#lines] .. ed
  return lines
end

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

---add surround chars
local function add_surround()
  local Char = getchar()
  -- if no char are inputed or char is <esc>, return
  if not Char[1] then
    feedkeys('<ESC>', 'n')
    return
  end

  local char = Char[2]
  local sr, sc, er, ec = getsurround.visual() -- get visual pos

  if vim.fn.mode() == 'V' then -- if mode is visual line, update start and end row's pos
    sc, ec = vim.fn.indent(sr) + 1, string.len(vim.fn.getline(er))
  end

  if check_zh(er, ec) then -- if is ends in zh
    ec = ec + 2 -- move the endrow back by 2
  end

  -- add pair to the selection
  if sr == er then
    local line = vim.fn.getline(sr)
    local line_mid = string.sub(line, sc, ec)
    line_mid = add_surround_chars_to_lines({ line_mid }, char)[1]
    vim.fn.setline(
      sr,
      (sc == 1 and '' or string.sub(line, 1, sc - 1))
        .. line_mid
        .. (ec == #line and '' or string.sub(line, ec + 1))
    )
  else
    local lines, linee = vim.fn.getline(sr), vim.fn.getline(er)
    local lines_mid, linee_mid = string.sub(lines, sc), string.sub(linee, 1, ec)
    local line = add_surround_chars_to_lines({ lines_mid, linee_mid }, char)
    lines_mid, linee_mid = line[1], line[#line]
    vim.fn.setline(sr, (sc == 1 and '' or string.sub(lines, 1, sc - 1)) .. lines_mid)
    vim.fn.setline(er, linee_mid .. (ec == #linee and '' or string.sub(linee, ec + 1)))
  end

  feedkeys('<ESC>', 'n')
end

---change surround chars
local function change_surround()
  -- enter the char to be replaced
  local Char = getchar()
  -- if no char are inputed or char is <esc>, return
  if not Char[1] then
    return
  end

  local char_odd = Char[2]
  -- enter the char to replace
  Char = getchar()
  if not Char[1] then
    return
  end
  local char_new = keys[Char[2]]
  local pos = getsurround.get_surround_pos(char_odd)
  vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2], { char_new.st })
  vim.api.nvim_buf_set_text(0, pos[3] - 1, pos[4] - 1, pos[3] - 1, pos[4], { char_new.ed })
end

return {
  add_surround = add_surround,
  change_surround = change_surround,
}
