local api = vim.api
local win = {}

---set float window's anchor
---@param opts table
---@return string anchor
local function make_floating_popup_anchor(opts)
  local anchor = ''

  anchor = anchor .. (opts.height >= 0 and 'N' or 'S')
  anchor = anchor .. (opts.width >= 0 and 'W' or 'E')

  return anchor or 'NW'
end

---set folating window's size
---@param opts table
---@param ui table {height: integer, width:integer}
---@return integer width
---@return integer height
local function make_floating_popup_size(opts, ui)
  opts.width = opts.width >= 0 and opts.width or -opts.width
  opts.height = opts.height >= 0 and opts.height or -opts.height

  opts.width = opts.width < 1 and math.floor(ui.width * opts.width + 0.5) or opts.width
  opts.height = opts.height < 1 and math.floor(ui.height * opts.height + 0.5) or opts.height

  opts.height, opts.width = math.min(opts.height, ui.height), math.min(opts.width, ui.width)

  return opts.width, opts.height
end

---get windows position
---@param opts table {row: char|integer, col: char|integer}
---@param ui table {height: integer, width:integer}
---@return integer row
---@return integer col
local function get_position(opts, ui)
  local row, col

  if type(opts.row) == 'number' then
    row = opts.row
  elseif opts.row == 'c' then
    row = math.floor((ui.height - opts.height) / 2 + 0.5)
  elseif opts.row == 't' then
    row = 0
  elseif opts.row == 'b' then
    row = ui.height - 1
  end

  if type(opts.col) == 'number' then
    col = opts.col
  elseif opts.col == 'c' then
    col = math.floor((ui.width - opts.width) / 2 + 0.5)
  elseif opts.col == 'l' then
    col = 0
  elseif opts.col == 'r' then
    col = ui.width
  end

  return row, col
end

---float window's config
---@param opts table
---@return table
local function make_floating_popup_options(opts)
  local ui = vim.api.nvim_list_uis()[1]
  local anchor = opts.anchor or make_floating_popup_anchor(opts)
  opts.width, opts.height = make_floating_popup_size(opts, ui)
  local row, col = get_position(opts, ui)

  return {
    anchor = anchor,
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

---default window's config
---@return table
local function default()
  return {
    style = 'minimal',
    border = 'rounded',
    noautocmd = false,
  }
end

---get window's information
---@return integer bunnr
---@return integer winid
function win:wininfo()
  return self.bufnr, self.winid
end

---creat float window
---@param float_opt table
---@param enter boolean
---@param force boolean
---@return table
function win:new_float(float_opt, enter, force)
  enter = enter or false

  -- buffer reuse
  self.bufnr = float_opt.bufnr or api.nvim_create_buf(false, false)
  float_opt.bufnr = nil
  float_opt = force and make_floating_popup_options(float_opt)
    or vim.tbl_extend('force', default(), float_opt)
  self.winid = api.nvim_open_win(self.bufnr, enter, float_opt)
  return self
end

--- quick set position
--- +-------------+--+-------------+--+--------------+
--- |             |  |             |  |              |
--- |     tl      |  |     tc      |  |      tr      |
--- |             |  |             |  |              |
--- +-------------+  +-------------+  +--------------+
--- |                                                |
--- +-------------+  +-------------+  +--------------+
--- |             |  |             |  |              |
--- |     cl      |  |     cc      |  |      cl      |
--- |             |  |             |  |              |
--- +-------------+  +-------------+  +--------------+
--- |                                                |
--- +-------------+  +-------------+  +--------------+
--- |             |  |             |  |              |
--- |     bl      |  |     bc      |  |      br      |
--- |             |  |             |  |              |
--- +-------------+--+-------------+--+--------------+

return win
