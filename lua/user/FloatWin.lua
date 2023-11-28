local FloatWin = {}

local function getpos(width, height, pos, ui)
  local x, y, anchor = 0, 0, ''
  if type(pos) == 'string' then
    if pos:sub(1, 1) == 'c' then
      anchor = anchor .. 'N'
      y = math.ceil((ui.height - height) / 2)
    elseif pos:sub(1, 1) == 't' then
      anchor = anchor .. 'N'
      y = 1
    elseif pos:sub(1, 1) == 'b' then
      anchor = anchor .. 'S'
      y = ui.height - 1
    end
    if pos:sub(2, 2) == 'c' then
      anchor = anchor .. 'W'
      x = math.ceil((ui.width - width) / 2)
    elseif pos:sub(2, 2) == 'l' then
      anchor = anchor .. 'W'
      x = 0
    elseif pos:sub(2, 2) == 'r' then
      anchor = anchor .. 'E'
      x = ui.width
    end
  else
    x, y = pos[1], pos[2]
  end
  return x, y, anchor
end

local function update(win, val, ui)
  if 0 < win.width and win.width < 1 then
    win.width = math.ceil(ui.width * win.width)
  end
  if 0 < win.height and win.height < 1 then
    win.height = math.ceil(ui.height * win.height)
  end
  if val.lines then
    for _, v in ipairs(val.lines) do
      win.width = math.max(win.width, vim.fn.strchars(v))
    end
    win.height = math.max(win.height, #val.lines)
  end
  win.width, win.height = math.min(win.width, ui.width), math.min(win.height, ui.height)
  return win
end

local function float_win_opt(opt, val)
  local ui = vim.api.nvim_list_uis()[1]
  local win = vim.tbl_extend("force", {
    anchor = 'NW',
    relative = 'editor',
    width = math.ceil(ui.width / 2),
    height = math.ceil(ui.height / 2),
    style = 'minimal',
    border = 'rounded',
    title = '',
    title_pos = 'center',
  }, opt or {})
  win = update(win, val, ui)
  win.col, win.row, win.anchor = getpos(win.width, win.height, val.pos, ui)
  return win
end

function FloatWin:GetInfo()
  return {
    width = FloatWin.win.width,
    height = FloatWin.win.height,
    col = FloatWin.win.col,
    row = FloatWin.win.row,
    bufnr = FloatWin.bufnr,
  }
end

-- @type
-- opt = {
--   anchor = 'NW',
--   relative = 'editor',
--   width = math.ceil(ui.width / 2),
--   height = math.ceil(ui.height / 2),
--   style = 'minimal',
--   border = 'rounded',
--   title = '',
--   title_pos = 'center',
-- }
-- val = {
--   lines = {},
--   buflisted = false,
--   pos = 'cc',
-- }
function FloatWin:Create(opt, val)
  val = vim.tbl_extend('force', {
    lines = {},
    buflisted = false,
    pos = 'cc',
    name = ''
  }, val or {})
  FloatWin.win = float_win_opt(opt, val)
  FloatWin.bufnr = vim.api.nvim_create_buf(val.buflisted, true)
  vim.api.nvim_buf_set_name(FloatWin.bufnr, val.name)
  vim.api.nvim_open_win(FloatWin.bufnr, true, FloatWin.win)
end

function FloatWin:Print(lines, pos)
  if type(lines) == 'string' then
    lines = { lines }
  end
  FloatWin:Create({
    width = 0,
    height = 0,
  }, {
    lines = lines,
    pos = pos,
  }
  )
  vim.api.nvim_buf_set_lines(FloatWin.buf, 0, -1, false, lines)
end

return FloatWin
