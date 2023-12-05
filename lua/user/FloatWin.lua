local FloatWin = {}

local function getpos(width, height, pos, ui)
  local x, y, anchor = 0, 0, ''
  if type(pos) == 'string' then
    if pos:sub(1, 1) == 'c' then
      anchor = anchor .. 'N'
      x = math.ceil((ui.height - height) / 2)
    elseif pos:sub(1, 1) == 't' then
      anchor = anchor .. 'N'
      x = 1
    elseif pos:sub(1, 1) == 'b' then
      anchor = anchor .. 'S'
      x = ui.height - 1
    end
    if pos:sub(2, 2) == 'c' then
      anchor = anchor .. 'W'
      y = math.ceil((ui.width - width) / 2)
    elseif pos:sub(2, 2) == 'l' then
      anchor = anchor .. 'W'
      y = 0
    elseif pos:sub(2, 2) == 'r' then
      anchor = anchor .. 'E'
      y = ui.width
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
  win.height, win.width = math.min(win.height, ui.height), math.min(win.width, ui.width)
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
  win.row, win.col, win.anchor = getpos(win.width, win.height, val.pos, ui)
  return win
end

function FloatWin:GetInfo()
  return {
    width = FloatWin.win.width,
    height = FloatWin.win.height,
    col = FloatWin.win.col,
    row = FloatWin.win.row,
    bufnr = FloatWin.bufnr,
    winnr = FloatWin.winnr,
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
  }, val or {})
  FloatWin.win = float_win_opt(opt, val)
  FloatWin.bufnr = vim.api.nvim_create_buf(val.buflisted, true)
  FloatWin.winnr = vim.api.nvim_open_win(FloatWin.bufnr, true, FloatWin.win)
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
  })
  vim.api.nvim_buf_set_lines(FloatWin.buf, 0, -1, false, lines)
end

return FloatWin
