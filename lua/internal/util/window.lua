local api = vim.api
local win = {}

local function get_position(opts, ui)
  local row, col
  if type(opts.pos.col) == 'string' then
    if opts.pos.row == 'c' then
      row = math.ceil((ui.height - opts.height) / 2)
    elseif opts.pos.row == 't' then
      row = 1
    elseif opts.pos.row == 'b' then
      row = ui.height - 1
    end

    if opts.pos.col == 'c' then
      col = math.ceil((ui.width - opts.width) / 2)
    elseif opts.pos.col == 'l' then
      col = 0
    elseif opts.pos.col == 'r' then
      col = ui.width
    end
  else
    row, col = opts.pos.row, opts.pos.col
  end
  return row, col
end

local function update(opts, ui)
  if 0 < opts.width and opts.width < 1 then
    opts.width = math.ceil(ui.width * opts.width)
  end
  if 0 < opts.height and opts.height < 1 then
    opts.height = math.ceil(ui.height * opts.height)
  end
  opts.height, opts.width = math.min(opts.height, ui.height), math.min(opts.width, ui.width)
  return opts.width, opts.height
end

local function make_floating_popup_options(opts)
  local ui = vim.api.nvim_list_uis()[1]
  opts.width, opts.height = update(opts, ui)
  local row, col = get_position(opts, ui)
  return {
    anchor = opts.anchor or 'NW',
    bufpos = opts.relative == 'win' and opts.bufpos or nil,
    row = row,
    col = col,
    focusable = opts.focusable or true,
    relative = opts.relative or 'cursor',
    style = 'minimal',
    width = opts.width,
    height = opts.height,
    border = opts.border or 'rounded',
    title = opts.title or '',
    title_pos = opts.title_pos or 'center',
    zindex = opts.zindex or 50,
    noautocmd = opts.noautocmd or false,
  }
end

local function default()
  return {
    style = 'minimal',
    border = 'rounded',
    noautocmd = false,
  }
end

function win:wininfo()
  return self.bufnr, self.winid
end

function win:new_float(float_opt, enter, force)
  enter = enter or false

  self.bufnr = float_opt.bufnr or api.nvim_create_buf(false, false)
  float_opt.bufnr = nil
  float_opt = not force and make_floating_popup_options(float_opt)
    or vim.tbl_extend('force', default(), float_opt)
  float_opt.pos = nil
  self.winid = api.nvim_open_win(self.bufnr, enter, float_opt)
  return self
end

return win
