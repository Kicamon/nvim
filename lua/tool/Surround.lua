local function SurroundChars(line, char)
  if char == "'" or char == '"' then
    line[1] = char .. line[1]
    line[#line] = line[#line] .. char
  elseif char == '(' or char == ')' then
    line[1] = '(' .. line[1]
    line[#line] = line[#line] .. ')'
  elseif char == '[' or char == ']' then
    line[1] = '[' .. line[1]
    line[#line] = line[#line] .. ']'
  elseif char == '{' or char == '}' then
    line[1] = '{' .. line[1]
    line[#line] = line[#line] .. '}'
  elseif char == '<' or char == '>' then
    line[1] = '<' .. line[1]
    line[#line] = line[#line] .. '>'
  else
    line[1] = char .. line[1]
    line[#line] = line[#line] .. char
  end
  return line
end

local feedkeys = function(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function getchar()
  local ok, char = pcall(vim.fn.getcharstr)
  if char == '\x1b' then
    ok = false
  end
  return { ok, char }
end

local function check_zh(lnum, cnum)
  return (vim.fn.getline(lnum):sub(cnum):find('[\227-\233\128-\191]') == 1)
end

local function Add_Surround()
  local getsurround = require('tool.util.GetSurround')
  local Char = getchar()
  if not Char[1] then
    feedkeys('<ESC>', 'n')
    return
  end
  local char = Char[2]
  local sl, sr, el, er = getsurround.Visual()
  if vim.fn.mode() == 'V' then
    sr, er = vim.fn.indent(sl) + 1, string.len(vim.fn.getline(el))
  end
  if check_zh(el, er) then
    er = er + 2
  end
  if sl == el then
    local line = vim.fn.getline(sl)
    local line_mid = string.sub(line, sr, er)
    local L = SurroundChars({ line_mid }, char)
    line_mid = L[1]
    vim.fn.setline(sl,
      (sr == 1 and '' or string.sub(line, 1, sr - 1)) .. line_mid .. (er == #line and '' or string.sub(line, er + 1)))
  else
    local lines, linee = vim.fn.getline(sl), vim.fn.getline(el)
    local lines_mid, linee_mid = string.sub(lines, sr), string.sub(linee, 1, er)
    local line = SurroundChars({ lines_mid, linee_mid }, char)
    lines_mid, linee_mid = line[1], line[#line]
    vim.fn.setline(sl, (sr == 1 and '' or string.sub(lines, 1, sr - 1)) .. lines_mid)
    vim.fn.setline(el, linee_mid .. (er == #linee and '' or string.sub(linee, er + 1)))
  end
  feedkeys('<ESC>', 'n')
end

local function Change_Surround()
  local getsurround = require('tool.util.GetSurround')
  local Char = getchar()
  if not Char[1] then
    return
  end
  local char_odd = Char[2]
  Char = getchar()
  if not Char[1] then
    return
  end
  local char_new = getsurround.Schar[getsurround.GetScharIndex(Char[2])]
  local pos = getsurround.GetSurround(char_odd)
  vim.api.nvim_buf_set_text(0, pos[1] - 1, pos[2] - 1, pos[1] - 1, pos[2], { char_new[1] })
  vim.api.nvim_buf_set_text(0, pos[3] - 1, pos[4] - 1, pos[3] - 1, pos[4], { char_new[2] })
end

return {
  Add_Surround = Add_Surround,
  Change_Surround = Change_Surround,
}
