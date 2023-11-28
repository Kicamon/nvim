local win = require("user.FloatWin")

local feedkeys = function(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function split()
  win:Create({
    width = 0.25,
    height = 0.86,
    title = ' Code Running '
  }, {
    buflisted = true,
    pos = 'tr',
  })
end

local function Run()
  vim.cmd('w')
  local filename = vim.api.nvim_buf_get_name(0)
  filename = vim.fn.pathshorten(vim.fn.fnamemodify(filename, ':p:~:t'))
  local runfile = filename:match("([^.]+)")

  if (vim.bo.filetype == 'c') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      vim.cmd('term gcc ' .. filename .. ' -o ' .. runfile .. ' && ./' .. runfile .. ' && rm -f ' .. runfile)
    end
  elseif (vim.bo.filetype == 'cpp') then
    split()
    if (vim.fn.filereadable('Makefile') == 1) then
      vim.cmd('term make && ./Main')
    else
      vim.cmd('term g++ ' ..
        filename .. ' -std=c++17 -O2 -g -Wall -o ' .. runfile .. ' && ./' .. runfile .. ' && rm -rf ' .. runfile)
    end
  elseif (vim.bo.filetype == 'python') then
    split()
    vim.cmd('term python3 ' .. filename)
  elseif (vim.bo.filetype == 'lua') then
    split()
    vim.cmd('term lua  ' .. filename)
  elseif (vim.bo.filetype == 'markdown') then
    vim.cmd('MarkdownPreview')
  elseif (vim.bo.filetype == 'sh') then
    split()
    vim.cmd('term bash  ' .. filename)
  elseif (vim.bo.filetype == 'html') then
    vim.cmd("tabe")
    vim.cmd("term live-server --browser=" .. vim.g.browser)
    vim.cmd("tabclose")
    feedkeys('<ESC>', 'n')
  end
end

vim.keymap.set('n', '<F5>', Run, {})
