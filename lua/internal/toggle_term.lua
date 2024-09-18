local win = require('internal.util.window')
local api = vim.api
local buffers = {}
local win_positions = {}
local toggle_term = {}
local infos = {
  idx = 0,
}

local float_opt_center = {
  width = 0.8,
  height = 0.8,
  title = ' Terminal ',
  relative = 'editor',
  row = 'c',
  col = 'c',
}

local float_opt_right = {
  width = -0.25,
  height = 0.9,
  title = ' Terminal ',
  relative = 'editor',
  row = 't',
  col = 'r',
}

local function toggle_open(bufnr)
  api.nvim_set_option_value('modified', false, { buf = bufnr })
  return win:new_float(win_positions[bufnr], true, true):bufopt('bufhidden', 'hide'):wininfo()
end

function toggle_term.new()
  if infos.winid then
    toggle_term.quit()
  end

  infos.idx = infos.idx + 1
  infos.bufnr, infos.winid =
    win:new_float(float_opt_center, true, true):bufopt('bufhidden', 'hide'):wininfo()
  vim.fn.termopen('zsh', {
    on_exit = function()
      toggle_term.quit()
    end,
  })
  table.insert(buffers, infos.bufnr)
  win_positions[infos.bufnr] = float_opt_center
end

function toggle_term.toggle()
  if #buffers == 0 then
    toggle_term.new()
    return
  end

  if infos.winid then
    toggle_term.quit()
  else
    infos.bufnr = buffers[infos.idx]
    win_positions[infos.bufnr].bufnr = infos.bufnr
    infos.bufnr, infos.winid = toggle_open(infos.bufnr)
    vim.cmd('startinsert')
  end
end

function toggle_term.quit()
  pcall(api.nvim_win_close, infos.winid, true)
  infos.winid = nil
end

function toggle_term.delete()
  table.remove(buffers, infos.idx)
  infos.idx = infos.idx - 1 > 0 and infos.idx - 1 or #buffers
  toggle_term.quit()
  api.nvim_buf_delete(infos.bufnr, { force = true })
end

function toggle_term.next()
  if not infos.winid then
    return
  end

  toggle_term.quit()
  infos.idx = infos.idx + 1 <= #buffers and infos.idx + 1 or 1
  infos.bufnr = buffers[infos.idx]
  win_positions[infos.bufnr].bufnr = infos.bufnr
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

function toggle_term.prev()
  if not infos.winid then
    return
  end

  toggle_term.quit()
  infos.idx = infos.idx - 1 > 0 and infos.idx - 1 or #buffers
  infos.bufnr = buffers[infos.idx]
  win_positions[infos.bufnr].bufnr = infos.bufnr
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

function toggle_term.right()
  if not infos.winid then
    return
  end

  win_positions[infos.bufnr] = float_opt_right
  win_positions[infos.bufnr].bufnr = infos.bufnr
  toggle_term.quit()
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

function toggle_term.center()
  if not infos.winid then
    return
  end

  win_positions[infos.bufnr] = float_opt_center
  win_positions[infos.bufnr].bufnr = infos.bufnr
  toggle_term.quit()
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

return toggle_term
