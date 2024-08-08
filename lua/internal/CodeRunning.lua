local function feedkeys(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local RunWin = coroutine.create(function(opt, full)
  local Win = require('internal.util.FloatWin')
  while true do
    Win:Create({
      anchor = full and 'NW' or 'NE',
      width = full and 0.7 or 0.25,
      height = full and 0.7 or 0.9,
      title = '  Code Running ',
    }, {
      buflisted = true,
      pos = full and 'cc' or 'tr',
    })
    vim.cmd.set('filetype=toggleterm')
    vim.cmd.term(opt)
    coroutine.yield()
  end
end)

local live_server = coroutine.create(function()
  while true do
    vim.cmd.tabe()
    vim.cmd.term('live-server --browser=' .. _G.browser)
    vim.cmd.tabclose()
    feedkeys('<ESC>', 'n')
    coroutine.yield()
  end
end)

local function Run(full)
  vim.cmd('w')
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')
  local runfile = vim.fn.expand('%<')
  vim.cmd('silent! lcd %:p:h')
  if filetype == 'c' then
    vim.schedule(function()
      coroutine.resume(
        RunWin,
        string.format(
          'gcc "%s" -o "%s" && ./"%s" && rm -f "%s"',
          filename,
          runfile,
          runfile,
          runfile
        ),
        full
      )
    end)
  elseif filetype == 'cpp' then
    vim.schedule(function()
      coroutine.resume(
        RunWin,
        string.format(
          'g++ "%s" -std=c++17 -o2 -g -Wall -o "%s" && ./"%s" && rm -rf "%s"',
          filename,
          runfile,
          runfile,
          runfile
        ),
        full
      )
    end)
  elseif filetype == 'python' then
    vim.schedule(function()
      coroutine.resume(RunWin, 'python3 ' .. filename, full)
    end)
  elseif filetype == 'lua' then
    vim.schedule(function()
      coroutine.resume(RunWin, 'luajit ' .. filename, full)
    end)
  elseif filetype == 'sh' then
    vim.schedule(function()
      coroutine.resume(RunWin, 'bash' .. filename, full)
    end)
  elseif filetype == 'markdown' then
    require('internal.MdPreview').MarkdownPreview()
  elseif filetype == 'html' then
    vim.schedule(function()
      coroutine.resume(live_server)
    end)
  else
    vim.notify('Undefined\n')
  end
end

return {
  running = Run,
}
