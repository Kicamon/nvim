local api, fn = vim.api, vim.fn
local function feedkeys(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function stop_hl()
  if vim.v.hlsearch == 0 then
    return
  end
  feedkeys('<Cmd>nohl<CR>', 'n')
end

local function start_hl()
  local res, ok = fn.getreg('/'), true
  if vim.v.hlsearch ~= 1 then
    return
  end
  if res:find([[%#]], 1, true) then
    stop_hl()
    return
  end
  ok, res = pcall(fn.search, [[\%#\zs]] .. res, 'cnW')
  if ok and res == 0 then
    stop_hl()
    return
  end
end

return {
  start_hl = start_hl,
  stop_hl = stop_hl,
}

