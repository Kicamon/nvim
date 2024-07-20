local api = vim.api

require('tools.CursorWord')

local function ele_in_table(ele, tab)
  for _, v in ipairs(tab) do
    if v == ele then
      return true
    end
  end
  return false
end

--- CodeRunning
api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'c', 'cpp', 'python', 'lua', 'markdown', 'sh', 'html' },
  callback = function()
    vim.keymap.set('n', '<F5>', function()
      require('tools.CodeRunning').running(false)
    end, { silent = true })
    vim.keymap.set('n', '<F10>', function()
      require('tools.CodeRunning').running(true)
    end, { silent = true })
  end
})

--- Image Paste
api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = "*.md",
  callback = function()
    vim.keymap.set('n', '<leader>P', function()
      require('tools.Image').paste()
    end)
  end
})

api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  callback = function()
    --- Chdir
    vim.api.nvim_create_user_command('Chdir', function()
      require('tools.Chdir').Chdir()
    end, { nargs = 0 })

    --- ImSwitch
    api.nvim_create_autocmd('InsertLeave', {
      callback = function()
        require('tools.ImSwitch').En()
      end
    })
    api.nvim_create_autocmd('InsertEnter', {
      callback = function()
        local buf_info = vim.fn.expand('%:e')
        if ele_in_table(buf_info, { 'md', 'txt' }) then
          if require('tools.ImSwitch').filetype_checke() then
            require('tools.ImSwitch').Zh()
          end
        end
      end
    })

    --- GetNode
    vim.keymap.set('n', '<leader>N', function()
      require('tools.GetNode').GetNode()
    end, { silent = true })

    ---  QuickSubstitute
    vim.keymap.set({ 'n', 'v' }, '<leader>ss', function()
      require('tools.QuickSubstitute').QuickSubstitute()
    end, { silent = true })

    --- MdTableFormat
    api.nvim_create_autocmd('InsertLeave', {
      pattern = "*.md",
      callback = function()
        require('tools.MdTableFormat').format_markdown_table()
      end
    })
    api.nvim_create_autocmd('TextChangedI', {
      pattern = "*.md",
      callback = function()
        require('tools.MdTableFormat').format_markdown_table_lines()
      end
    })

    --- Surround
    vim.keymap.set('v', 'S', function()
      require('tools.Surround').Add_Surround()
    end, { silent = true })
    vim.keymap.set('n', 'cs', function()
      require('tools.Surround').Change_Surround()
    end, { silent = true })

    --- TabToSpace
    vim.keymap.set('n', '<leader>ts', function()
      require('tools.TabToSpace').TabToSpace()
    end, { silent = true })

    --- Wildfire
    vim.keymap.set({ 'n', 'v' }, '<cr>', function()
      require('tools.Wildfire').Wildfire()
    end, { silent = true })

    --- Align
    vim.keymap.set('v', 'ga', function()
      require('tools.Align').align()
    end, { silent = true })
  end
})

api.nvim_create_autocmd({ 'VimEnter' }, {
  callback = function()
    --- Yazi
    local Yazi = require('tools.Yazi').Yazi
    vim.keymap.set('n', '<leader>ra', function() Yazi('edit') end, { silent = true })
    vim.keymap.set('n', '<leader>rh', function() Yazi('vsplit', 'left') end, { silent = true })
    vim.keymap.set('n', '<leader>rj', function() Yazi('split', 'down') end, { silent = true })
    vim.keymap.set('n', '<leader>rk', function() Yazi('split', 'up') end, { silent = true })
    vim.keymap.set('n', '<leader>rl', function() Yazi('vsplit', 'right') end, { silent = true })
    vim.api.nvim_create_user_command('Yazi', function() Yazi('edit') end, { nargs = 0 })

    --- Wiki
    vim.keymap.set('n', '<leader>ww', function()
      require('tools.Wiki').OpenWiki()
    end, { silent = true })
  end
})
