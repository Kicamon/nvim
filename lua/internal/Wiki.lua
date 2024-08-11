local function feedkeys(keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function create_open()
  local ts_utils = require('nvim-treesitter.ts_utils')
  local node = ts_utils.get_node_at_cursor()
  if node then
    if node:type() == 'link_text' or node:type() == 'link_destination' then
      local line = vim.api.nvim_get_current_line()
      local pattern = '[^/]+(.-)%)'
      local path = string.match(line, pattern)
      path = vim.fn.expand('%:p:~:h') .. path
      vim.cmd('edit ' .. path)
    elseif node:type() == 'inline' then
      local tl, tr = vim.fn.getpos('v')[3], vim.fn.getpos('.')[3]
      local line = vim.api.nvim_get_current_line()
      if line:sub(tr):find('[\227-\233\128-\191]') == 1 then
        tr = tr + 2
      end
      local file_name = string.sub(line, tl, tr)
      local file_link = './' .. string.gsub(file_name, ' ', '_') .. '.md'
      local line_front = tl == 1 and '' or string.sub(line, 1, tl - 1)
      local line_end = tr == #line and '' or string.sub(line, tr + 1)
      local line_mid = string.format('[%s](%s)', file_name, file_link)
      vim.api.nvim_set_current_line(line_front .. line_mid .. line_end)
      feedkeys('<ESC>', 'n')
    end
  else
    return
  end
end

local function open_wiki()
  if vim.fn.filereadable(vim.fn.expand('~/Documents/study/Note/wiki/index.md')) == 0 then
    vim.cmd('silent !mkdir -p ~/Documents/study/Note/wiki')
    vim.cmd('silent !touch ~/Documents/study/Note/wiki/index.md')
  end
  vim.cmd('edit ~/Documents/study/Note/wiki/index.md')
end

return {
  open_wiki = open_wiki,
  create_open = create_open,
}
