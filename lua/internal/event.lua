local au = vim.api.nvim_create_autocmd
local uc = vim.api.nvim_create_user_command
local map = require('core.keymap')

local function ele_in_table(ele, tab)
  for _, v in ipairs(tab) do
    if v == ele then
      return true
    end
  end
  return false
end

--- CodeRunning
au({ 'FileType' }, {
  pattern = { 'c', 'cpp', 'python', 'lua', 'markdown', 'sh', 'html' },
  callback = function()
    map.n({
      ['<F5>'] = function()
        require('internal.CodeRunning').running(false)
      end,
      ['<F10>'] = function()
        require('internal.CodeRunning').running(true)
      end,
    }, { silent = true })
  end
})

--- ImSwitch
au('InsertLeave', {
  callback = function()
    require('internal.ImSwitch').En()
  end
})
au('InsertEnter', {
  callback = function()
    local buf_info = vim.fn.expand('%:e')
    if ele_in_table(buf_info, { 'md', 'txt' }) then
      if require('internal.ImSwitch').filetype_checke() then
        require('internal.ImSwitch').Zh()
      end
    end
  end
})

--- MdTableFormat
au('InsertLeave', {
  pattern = "*.md",
  callback = function()
    require('internal.MdTableFormat').format_markdown_table()
  end
})

au('TextChangedI', {
  pattern = "*.md",
  callback = function()
    require('internal.MdTableFormat').format_markdown_table_lines()
  end
})

--- Pairs
au({'InsertEnter', 'CmdlineEnter'},{
  callback = function()
    require('internal.Pair')
  end
})

au('TermOpen', { pattern = 'term://*', command = [[startinsert]] })

au('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 200 })
  end
})

au('BufEnter', {
  once = true,
  callback = function()
    vim.cmd('set formatoptions-=ro')
    require('keymap')
    local Yazi = require('internal.Yazi').Yazi
    map.n({
      -- yazi
      ['ra'] = function() Yazi('edit') end,
      ['rh'] = function() Yazi('vsplit', 'left') end,
      ['rj'] = function() Yazi('split', 'down') end,
      ['rk'] = function() Yazi('split', 'up') end,
      ['rl'] = function() Yazi('vsplit', 'right') end,
      -- wiki
      ['<leader>ww'] = function() require('internal.Wiki').OpenWiki() end
    })
    uc('Yazi', function() Yazi('edit') end, { nargs = 0 })
  end
})

au({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    require('keymap.markdown')
  end
})

au({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    --- last plase
    local pos = vim.fn.getpos("'\"")
    if pos[2] > 0 and pos[2] <= vim.fn.line('$') then
      vim.api.nvim_win_set_cursor(0, { pos[2], pos[3] - 1 })
    end
    --- lines
    require('internal.lines').setup()
    --- cursorword
    require('internal.CursorWord')

    --- Chdir
    uc('Chdir', function()
      require('internal.Chdir').Chdir()
    end, { nargs = 0 })

    map.n({
      --- Surround
      ['cs'] = function()
        require('internal.Surround').Change_Surround()
      end,
      --- TabToSpace
      ['<leader>ts'] = function()
        require('internal.TabToSpace').TabToSpace()
      end,
      --- GetNode
      ['<leader>N'] = function()
        require('internal.GetNode').GetNode()
      end,
    }, { silent = true })
    map.v({
      --- Surround
      ['S'] = function()
        require('internal.Surround').Add_Surround()
      end,
      --- Align
      ['ga'] = function()
        require('internal.Align').align()
      end
    }, { silent = true })
    map.nv({
      ---  QuickSubstitute
      ['<leader>ss'] = function()
        require('internal.QuickSubstitute').QuickSubstitute()
      end,
      --- Wildfire
      ['<cr>'] = function()
        require('internal.Wildfire').Wildfire()
      end,
    }, { silent = true })
  end
})
