local function feedkeys (keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function RunWin(opt, full)
  local Win = require("tool.util.FloatWin")
  Win:Create({
    anchor = full and 'NW' or 'NE',
    width = full and 0.7 or 0.25,
    height = full and 0.7 or 0.9,
    title = '  Code Running '
  }, {
    buflisted = true,
    pos = full and 'cc' or 'tr',
  })
  vim.cmd('set filetype=toggleterm')
  vim.cmd(opt)
end

local function Run(full)
  vim.cmd('w')
  local filetype = vim.bo.filetype
  local filename = vim.fn.expand('%')
  local runfile = vim.fn.expand('%<')
  vim.cmd('silent! lcd %:p:h')
  if filetype == 'c' then
    RunWin(string.format('term gcc "%s" -o "%s" && ./"%s" && rm -f "%s"', filename, runfile, runfile, runfile), full)
  elseif filetype == 'cpp' then
    RunWin(string.format('term g++ "%s" -std=c++17 -O2 -g -Wall -o "%s" && ./"%s" && rm -rf "%s"',
      filename, runfile, runfile, runfile), full)
  elseif filetype == 'python' then
    RunWin('term python3 ' .. filename, full)
  elseif filetype == 'lua' then
    RunWin('term luajit ' .. filename, full)
  elseif filetype == 'sh' then
    RunWin('term bash ' .. filename, full)
  elseif filetype == 'markdown' then
    require('tool.MdPreview').MarkdownPreview()
  elseif filetype == 'html' then
    vim.cmd([[
      tabe
      execute 'term live-server --browser=' . g:browser
      tabclose
    ]])
    feedkeys('<ESC>', 'n')
  end
end

return {
  running = Run
}
