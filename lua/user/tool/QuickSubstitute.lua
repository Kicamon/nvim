local getpos = require('user.tool.GetSurround').Visual

local function check(oldword, newword)
  if oldword == '' or newword == '' then
    vim.cmd("normal ! v")
    return true
  end
  return false
end

local pchar = {
  '/',
  '#',
}

local function Input(oldword)
  if not oldword then
    oldword = vim.fn.input("Enter word old: ")
  end
  local newword = vim.fn.input("Enter word new: ")
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
    char = vim.fn.input("Enter char: ")
  end
  return oldword, newword, char
end

local function QuickSubstitute()
  local oldword, newword, char
  if vim.fn.mode() == 'n' then
    oldword, newword, char = Input()
    if check(oldword, newword) then
      return
    end
    vim.cmd(':s' .. char .. oldword .. char .. newword .. char .. 'g')
  elseif vim.fn.mode() == 'v' or vim.fn.mode() == 'V' then
    local sl, sr, el, er = getpos()
    if sl == el then
      oldword, newword, char = Input(vim.fn.getline(sl):sub(sr, er))
      if check(oldword, newword) then
        return
      end
      vim.cmd(':s' .. char .. oldword .. char .. newword .. char .. 'g')
    else
      oldword, newword, char = Input()
      if check(oldword, newword) then
        return
      end
      vim.cmd(':' .. sl .. ',' .. el .. 's' .. char .. oldword .. char .. newword .. char .. 'g')
    end
    vim.cmd("normal ! v")
  end
  vim.cmd("noh")
end

vim.keymap.set({ 'n', 'v' }, '<leader>ss', QuickSubstitute, {})
