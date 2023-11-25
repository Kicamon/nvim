local FloatWin = {}

local function getpos(width, height, pos, ui)
  local x, y = 0, 0
  if pos.pos then
    if pos.pos:sub(1, 1) == 'c' then
      y = math.ceil((ui.height - height) / 2)
    elseif pos.pos:sub(1, 1) == 't' then
      y = 0
    elseif pos.pos:sub(1, 1) == 'b' then
      y = ui.height - height
    end
    if pos.pos:sub(2, 2) == 'c' then
      x = math.ceil((ui.width - width) / 2)
    elseif pos.pos:sub(2, 2) == 'l' then
      x = 0
    elseif pos.pos:sub(2, 2) == 'r' then
      x = ui.width - width
    end
  else
    x, y = pos.x, pos.y
  end
  return x, y
end

local function update(win, ui)
  if win.width < 1 then
    win.width = math.ceil(ui.width * win.width)
  end
  if win.height < 1 then
    win.height = math.ceil(ui.height * win.height)
  end
  if win.lines then
    for _, v in ipairs(win.lines) do
      win.width = math.max(win.width, vim.fn.strchars(v))
    end
    win.height = math.max(win.height, #win.lines)
  end
  win.width, win.height = math.min(win.width, ui.width), math.min(win.height, ui.height)
  return win
end

function FloatWin.Create(opt)
  local ui = vim.api.nvim_list_uis()[1]
  local win = vim.tbl_extend("force", {
    width = math.ceil(ui.width / 2),
    height = math.ceil(ui.height / 2),
    buflisted = false,
    title = '',
    lines = {},
    pos = { pos = 'cc' },
  }, opt or {})
  win = update(win, ui)
  local buf = vim.api.nvim_create_buf(win.buflisted, true)
  local x, y = getpos(win.width, win.height, win.pos, ui)
  local opts = {
    relative = 'editor',
    width = win.width,
    height = win.height,
    col = x,
    row = y,
    style = 'minimal',
    border = 'rounded',
    title = win.title,
    title_pos = 'center'
  }
  vim.api.nvim_open_win(buf, true, opts)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, win.lines)
end

return FloatWin
