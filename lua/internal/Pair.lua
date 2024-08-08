local config = {
  keys = {
    ['('] = { close = true, pair = '()' },
    ['['] = { close = true, pair = '[]' },
    ['{'] = { close = true, pair = '{}' },

    [')'] = { close = false, pair = '()' },
    [']'] = { close = false, pair = '[]' },
    ['}'] = { close = false, pair = '{}' },

    ['"'] = { close = true, pair = '""' },
    ["'"] = { close = true, pair = "''" },
    ['`'] = { close = true, pair = '``' },

    ['<cr>'] = {},
    ['<bs>'] = {},
  },
}

local function get_pair(mode)
  local line = mode == 'insert' and vim.api.nvim_get_current_line() or '_' .. vim.fn.getcmdline()
  local col = mode == 'insert' and vim.api.nvim_win_get_cursor(0)[2] or vim.fn.getcmdpos()

  return line:sub(col, col + 1)
end

local function is_pair(pair)
  for _, val in pairs(config.keys) do
    if pair == val.pair then
      return true
    end
  end
  return false
end

local function insert_pairs(key, val, mode)
  local pair = get_pair(mode)
  if key == '<cr>' and mode == 'insert' and is_pair(pair) then
    return '<cr><c-o>O'
  elseif key == '<bs>' and is_pair(pair) then
    return '<bs><del>'
  elseif val.close then
    return val.pair .. '<Left>'
  else
    return key
  end
end

for key, val in pairs(config.keys) do
  vim.keymap.set('i', key, function()
    return insert_pairs(key, val, 'insert')
  end, { noremap = true, expr = true })
  vim.keymap.set('c', key, function()
    return insert_pairs(key, val, 'command')
  end, { noremap = true, expr = true })
end
