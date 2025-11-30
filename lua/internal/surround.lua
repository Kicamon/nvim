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

---get surround char
---@param char string
---@param mode string
---@return string
---@return string
---@return string
local function get_surround_char(char, mode)
  local str = fn.getreg('"')

  local left, right = char, char
  if keys[char] then
    left, right = keys[char].left, keys[char].right
  end
  if str:find('\n') and mode == 'V' then
    left, right = '\n' .. left .. '\n', right .. '\n'
  end

  return str, left, right
end

---add surround chars
---@param char string
---@param mode string
---@return string
local function add(char, mode)
  vim.cmd('normal! d')

  local str, left, right = get_surround_char(char, mode)

  return left .. str .. right
end

---remove surround chars
---@param char string
---@return string
local function remove(char, _)
  vim.cmd('normal! da' .. char)
  local new_str = fn.getreg('"'):gsub('^(%s*)%S(.*)%S(%s*)$', '%1%2%3')
  return new_str
end

---change surround chars
---@param char string
---@param mode string
---@return string
local function change(char, mode)
  local ok, new_char = getchar()
  if not ok then
    return ''
  end

  vim.cmd('normal! da' .. char)

  local str, left, right = get_surround_char(new_char, mode)

  local new_str = str:gsub('^(%s*)%S(.*)%S(%s*)$', '%1' .. left .. '%2' .. right .. '%3')
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
  })[mode](char, fn.mode())

  fn.setreg('"', char, 'c')

  vim.notify(fn.line('.') .. ' ' .. fn.line('.'))
  if fn.col("'[") > #api.nvim_get_current_line() or fn.line("'[") > fn.line('.') then
    vim.cmd('normal! $p')
  else
    vim.cmd('normal! P')
  end

  api.nvim_win_set_cursor(0, cursor_pos)
end

return { surround = surround }
