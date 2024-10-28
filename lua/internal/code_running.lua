local win = require('internal.util.window')
local command = require('internal.code_running_commands').get_commands()
local api, expand = vim.api, vim.fn.expand
local infos = {}

---get running command and running modus by filetype
---@return table {command: string, modus: string}
local function get_commands(args)
  local filename = expand('%')
  local runfile = expand('%<')
  local workspace = vim.lsp.buf.list_workspace_folders()[1] or ''

  local opt = vim.deepcopy(command[args])

  if not opt then
    return opt
  end

  if type(opt.command) == 'table' then
    ---@diagnostic disable-next-line: param-type-mismatch
    opt.command = table.concat(opt.command, ' && ')
  end

  opt.command =
    opt.command:gsub('$filename', filename):gsub('$runfile', runfile):gsub('$workspace', workspace)

  return opt
end

---get the float terminal infos
---@param center boolean
---@return table
local function get_float_opt(center)
  return {
    width = center and 0.8 or -0.25,
    height = center and 0.8 or 0.9,
    relative = 'editor',
    title = ' Code Running ',
    row = center and 'c' or 't',
    col = center and 'c' or 'r',
  }
end

---create float window to running the command
---@param opt string
---@param center boolean
local function running_window(opt, center)
  local float_opt = get_float_opt(center)

  infos.bufnr, infos.winid =
    win:new_float(float_opt, true, true):bufopt('bufhidden', 'hide'):wininfo()

  api.nvim_create_autocmd('WinClosed', {
    buffer = infos.bufnr,
    callback = function()
      if infos.winid and api.nvim_win_is_valid(infos.winid) then
        api.nvim_win_close(infos.winid, true)
      end
      api.nvim_buf_delete(infos.bufnr, { force = true })
      infos.winid = nil
    end,
  })

  vim.cmd.term(opt)
end

---split a string by last space
---@param str string
---@return string
---@return boolean
local function split_by_last_space(str)
  local last_space = str:match('.*()%s')

  if not last_space then
    if str == 'center' then
      return '', true
    else
      return str, false
    end
  end

  local first_part = str:sub(1, last_space - 1)
  local second_part = str:sub(last_space + 1) == 'center'

  return first_part, second_part
end

---quick running code
---@param args string
local function running(args)
  vim.cmd('w')

  local workpath = vim.fn.getcwd()
  local center = false
  args, center = split_by_last_space(args)
  args = #args == 0 and vim.bo.filetype or args
  vim.cmd('silent! lcd %:p:h')

  local opt = get_commands(args)
  if opt then
    if opt.modus == 'job' then
      vim.fn.jobstart(opt.command)
    elseif opt.modus == 'cmd' then
      vim.cmd(opt.command)
    else
      center = center or opt.modus == 'center'
      running_window(opt.command, center)
    end
  else
    vim.notify(string.format("%s's running command is undefined\n", args), vim.log.levels.WARN)
  end

  vim.cmd('silent! lcd ' .. workpath)
end

return { running = running }
