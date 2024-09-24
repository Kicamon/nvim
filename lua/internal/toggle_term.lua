local win = require('internal.util.window')
local api = vim.api
local buffers = {}
local toggle_term = {}
local infos = {
  idx = 0,
}

local float_opt = {
  width = 0.8,
  height = 0.8,
  title = ' Terminal ',
  relative = 'editor',
  row = 'c',
  col = 'c',
}

local function toggle_open(bufnr)
  api.nvim_set_option_value('modified', false, { buf = bufnr })
  return win
    :new_float(vim.tbl_extend('force', float_opt, { bufnr = bufnr }), true, true)
    :bufopt('bufhidden', 'hide')
    :wininfo()
end

function toggle_term.new()
  if infos.winid then
    toggle_term.quit()
  end

  infos.idx = infos.idx + 1
  infos.bufnr, infos.winid =
    win:new_float(float_opt, true, true):bufopt('bufhidden', 'hide'):wininfo()
  vim.fn.termopen(os.getenv('SHELL'), {
    on_exit = function()
      toggle_term.quit()
    end,
  })
  table.insert(buffers, infos.bufnr)
end

function toggle_term.toggle()
  if not next(buffers) then
    toggle_term.new()
    return
  end

  if infos.winid then
    toggle_term.quit()
  else
    infos.bufnr = buffers[infos.idx]
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
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

function toggle_term.prev()
  if not infos.winid then
    return
  end

  toggle_term.quit()
  infos.idx = infos.idx - 1 > 0 and infos.idx - 1 or #buffers
  infos.bufnr = buffers[infos.idx]
  infos.bufnr, infos.winid = toggle_open(infos.bufnr)
end

return toggle_term
