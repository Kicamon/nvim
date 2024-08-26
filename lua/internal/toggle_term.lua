local api = vim.api
local win = require('internal.util.window')
local buffers = {}
local term = {}

local float_opt = {
  width = 0.8,
  height = 0.8,
  title = ' Terminal ',
  relative = 'editor',
  row = 'c',
  col = 'c',
}

local function toggle_open(bufnr)
  api.nvim_set_option_value('modified', false, { scope = 'local', buf = bufnr })
  return win:new_float(float_opt, true, true):wininfo()
end

function term:new()
  if self.winid then
    term:quit()
  end

  self.bufnr, self.winid = win:new_float(float_opt, true, true):wininfo()
  vim.cmd('term')
  table.insert(buffers, self.bufnr)
end

function term:toggle()
  if #buffers == 0 then
    self:new()
    return
  end

  self.idx = 1

  if self.winid then
    self:quit()
  else
    self.bufnr = buffers[1]
    float_opt.bufnr = self.bufnr
    self.bufnr, self.winid = toggle_open(self.bufnr)
    vim.cmd('startinsert')
  end
end

function term:quit()
  pcall(api.nvim_win_close, self.winid, true)
  self.winid = nil
end

function term:delete()
  table.remove(buffers, self.bufnr)
  self:quit()
  api.nvim_buf_delete(self.bufnr, { force = true })
end

function term:next()
  if not self.winid then
    return
  end

  self:quit()
  self.idx = self.idx - 1 <= #buffers and self.idx + 1 or 1
  self.bufnr = buffers[self.idx]
  float_opt.bufnr = self.bufnr
  self.bufnr, self.winid = toggle_open(self.bufnr)
end

function term:prev()
  if not self.winid then
    return
  end

  self:quit()
  self.idx = self.idx - 1 > 0 and self.idx - 1 or #buffers
  self.bufnr = buffers[self.idx]
  float_opt.bufnr = self.bufnr
  self.bufnr, self.winid = toggle_open(self.bufnr)
end

return term
