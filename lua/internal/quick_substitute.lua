local get_surround = require('internal.util.get_surround')
local pchar = { '/', '#' }

---check if oldword or newword is nil
---@param oldword string
---@param newword string
---@return boolean
local function check(oldword, newword)
  if oldword == '' or newword == '' then
    vim.cmd('normal ! v')
    return true
  end
  return false
end

---get oldword and newword
---@param oldword? string
---@return string
---@return string
---@return string
local function input_str(oldword)
  if not oldword then
    oldword = vim.fn.input('Enter word old: ')
  end
  local newword = vim.fn.input('Enter word new: ')
  local char = '/'
  local vis = true
  for _, c in ipairs(pchar) do
    if oldword:find(c) == nil and newword:find(c) == nil then
      char = c
      vis = false
      break
    end
  end
  if vis then
    char = vim.fn.input('Enter char: ')
  end
  return oldword, newword, char
end

---quick substitute string
local function quick_substitute()
  local getpos = get_surround.visual
  local oldword, newword, char
  if vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
    local sl, sr, el, er = getpos()
    local cmd_opt = ''

    if sl == el then -- change scope: one line
      oldword, newword, char = input_str(vim.fn.getline(sl):sub(sr, er))
      cmd_opt = string.format(':s%s%s%s%s%sg', char, oldword, char, newword, char)
    else -- change scope: visual scope
      oldword, newword, char = input_str()
      cmd_opt = string.format(':%d,%ds%s%s%s%s%sg', sl, el, char, oldword, char, newword, char)
    end

    if check(oldword, newword) then
      return
    end

    vim.cmd(cmd_opt)
    vim.cmd('normal ! v')
  end
  vim.cmd('noh')
end

return { quick_substitute = quick_substitute }
