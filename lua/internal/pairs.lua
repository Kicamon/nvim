local keys = {
  ['('] = { pair = '()' },
  ['['] = { pair = '[]' },
  ['{'] = { pair = '{}' },

  ['"'] = { pair = '""' },
  ["'"] = { pair = "''" },
  ['`'] = { pair = '``' },

  ['<cr>'] = {},
  ['<bs>'] = {},
}

---get pair in cursor
---@param mode string
---@return string
local function get_pair(mode)
  local line = mode == 'i' and vim.api.nvim_get_current_line() or '_' .. vim.fn.getcmdline()
  local col = mode == 'i' and vim.api.nvim_win_get_cursor(0)[2] or vim.fn.getcmdpos()

  return line:sub(col, col + 1)
end

---check if is a pair
---@param pair string
---@return boolean
local function is_pair(pair)
  for _, val in pairs(keys) do
    if pair == val.pair then
      return true
    end
  end
  return false
end

---add or delete pairs in cursor
---@param key string the key or pair char
---@param val table {close: boolean, pair: string}
---@return string
local function update_pairs(key, val)
  local mode = vim.fn.mode()
  local pair = get_pair(mode)

  if key == '<cr>' and mode == 'i' and is_pair(pair) then
    return '<cr><c-o>O'
  elseif key == '<bs>' and is_pair(pair) then
    return '<bs><del>'
  elseif val.pair then
    return val.pair .. '<Left>'
  end

  return key
end

for key, val in pairs(keys) do
  vim.keymap.set({ 'i', 'c' }, key, function()
    vim.schedule(function()
      vim.cmd('redraw')
    end)
    return update_pairs(key, val)
  end, { noremap = true, expr = true })
end
