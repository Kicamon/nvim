local api = vim.api
local win = require('internal.util.window')
local infos = {}

local float_opt = {
  width = 0.8,
  height = 0.8,
  title = ' Yazi ',
  relative = 'editor',
  row = 'c',
  col = 'c',
}

local set_split = {
  ['left'] = 'nosplitright',
  ['down'] = 'splitbelow',
  ['up'] = 'nosplitbelow',
  ['right'] = 'splitright',
}

local function open_file(open, opt)
  if opt then
    vim.cmd.set(set_split[opt])
  end

  if vim.fn.filereadable(vim.fn.expand(infos.tempname)) == 1 then
    local filenames = vim.fn.readfile(infos.tempname)
    for _, filename in ipairs(filenames) do
      vim.cmd(open .. ' ' .. filename)
    end
  end
end

local function end_options()
  vim.fn.delete(infos.tempname)
  vim.cmd('silent! lcd ' .. infos.workpath)
end

local function yazi(open, opt)
  infos.workpath = vim.fn.getcwd()
  infos.filename = api.nvim_buf_get_name(0)
  infos.tempname = vim.fn.tempname()

  vim.cmd('silent! lcd %:p:h')

  if infos.bufnr then
    float_opt.bufnr = infos.bufnr
    api.nvim_set_option_value('modified', false, { buf = infos.bufnr })
  end

  infos.bufnr, infos.winid =
    win:new_float(float_opt, true, true):bufopt('bufhidden', 'hide'):wininfo()

  vim.fn.termopen(string.format('yazi %s --chooser-file="%s"', infos.filename, infos.tempname), {
    on_exit = function()
      if api.nvim_win_is_valid(infos.winid) then
        api.nvim_win_close(infos.winid, true)
        open_file(open, opt)
      end
      infos.winid = nil
      end_options()
    end,
  })
end

return { yazi = yazi }
