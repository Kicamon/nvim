local api = vim.api

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

---get surround char
---@return table {ok: boolen, char: string}
local function getchar()
  local ok, char = pcall(vim.fn.getcharstr)
  if char == '\x1b' then
    ok = false
  end
  return { ok, char }
end

---add surround chars
local function add_surround(char)
  local left = keys[char] and keys[char].left or char
  local right = keys[char] and keys[char].right or char

  vim.cmd('normal! "ad')
  feedkeys('<ESC>', 'n')
  return left .. vim.fn.getreg('"') .. right
end

---remove surround chars
local function remove_surround(char)
  vim.cmd('normal! "ada' .. char)
  return vim.fn.getreg('a'):sub(2, -2)
end

---change surround chars
local function change_surround(char)
  local new_char = getchar()
  if not new_char[1] then
    return
  end

  new_char = new_char[2]
  local left = keys[new_char] and keys[new_char].left or new_char
  local right = keys[new_char] and keys[new_char].right or new_char

  vim.cmd('normal! ""da' .. char)
  return left .. vim.fn.getreg('"'):sub(2, -2) .. right
end

---surround function
---@param mode string{'add', 'remove', 'change'}
local function surround(mode)
  local cursor_pos = api.nvim_win_get_cursor(0)

  local char = getchar()
  if not char[1] then
    feedkeys('<esc>', 'n')
    return
  end

  if mode == 'add' then
    char[2] = add_surround(char[2])
  elseif mode == 'remove' then
    char[2] = remove_surround(char[2])
  elseif mode == 'change' then
    char[2] = change_surround(char[2])
  end

  vim.fn.setreg('"', char[2], 'b')
  vim.cmd('normal! ""P')
  api.nvim_win_set_cursor(0, cursor_pos)
end

return { surround = surround }
