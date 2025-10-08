local win = require('internal.util.window')
local api = vim.api
local infos = {}
local float_opt = {}

local function get_float_opt(opt)
  if opt == 'right' then
    return {
      width = 0.25,
      height = 0.9,
      title = ' Terminal ',
      relative = 'editor',
      row = 't',
      col = 'r',
    }
  end
  return {
    width = 0.8,
    height = 0.8,
    title = ' Terminal ',
    relative = 'editor',
    row = 'c',
    col = 'c',
  }
end

local function toggle_open(bufnr)
  api.nvim_set_option_value('modified', false, { buf = bufnr })
  infos.bufnr, infos.winid = win
    :new_float(vim.tbl_extend('force', float_opt, { bufnr = bufnr }), true, true)
    :bufopt('bufhidden', 'hide')
    :wininfo()
  vim.cmd('startinsert')
end

local function quit_term()
  pcall(api.nvim_win_close, infos.winid, true)
  infos.winid = nil
end

local function new_term()
  if infos.winid then
    quit_term()
  end

  infos.bufnr, infos.winid =
    win:new_float(float_opt, true, true):bufopt('bufhidden', 'hide'):wininfo()
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.fn.jobstart(os.getenv('SHELL'), {
    term = true,
    on_exit = function()
      quit_term()
    end,
  })
end

local function toggle_term(opt)
  if opt ~= nil then
    quit_term()
    float_opt = get_float_opt(opt)
    toggle_open(infos.bufnr)
    return
  end

  if infos.bufnr == nil then
    float_opt = get_float_opt()
    new_term()
    return
  end

  if infos.winid then
    quit_term()
  else
    toggle_open(infos.bufnr)
  end
end

return { toggle_term = toggle_term }
