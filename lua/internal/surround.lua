local api, fn = vim.api, vim.fn

local function feedkeys(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode, true)
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

  ["'"] = { left = "'", right = "'" },
  ['"'] = { left = '"', right = '"' },
  ['`'] = { left = '`', right = '`' },
}

---get char
---@return boolean
---@return string
local function getchar()
  local ok, char = pcall(fn.getcharstr)
  return ok and char ~= '\x1b', char
end

---add surround chars
---@param char string
---@return string
local function add(char)
  local left = keys[char] and keys[char].left or char
  local right = keys[char] and keys[char].right or char

  vim.cmd('normal! d')
  feedkeys('<ESC>', 'n')
  return left .. fn.getreg('"') .. right
end

---remove surround chars
---@param char string
---@return string
local function remove(char)
  vim.cmd('normal! da' .. char)
  local new_str = fn.getreg('"'):gsub('^(%s*)%S(.*)%S(%s*)$', '%1%2%3')
  return new_str
end

---change surround chars
---@param char string
---@return string
local function change(char)
  local ok, new_char = getchar()
  if not ok then
    return ''
  end

  local left = keys[new_char] and keys[new_char].left or new_char
  local right = keys[new_char] and keys[new_char].right or new_char

  vim.cmd('normal! da' .. char)
  local new_str = fn.getreg('"'):gsub('^(%s*)%S(.*)%S(%s*)$', '%1' .. left .. '%2' .. right .. '%3')
  return new_str
end

---surround function
---@param mode string{'add', 'remove', 'change'}
local function surround(mode)
  local cursor_pos = api.nvim_win_get_cursor(0)

  local ok, char = getchar()
  if not ok then
    return feedkeys('<esc>', 'n')
  end

  char = ({
    add = add,
    remove = remove,
    change = change,
  })[mode](char)

  fn.setreg('"', char, 'b')

  if fn.col("'[") > #api.nvim_get_current_line() then
    vim.cmd('normal! p')
  else
    vim.cmd('normal! P')
  end

  api.nvim_win_set_cursor(0, cursor_pos)
end

return { surround = surround }
