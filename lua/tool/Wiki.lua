local function feedkeys (keys, mode)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function Create_Open()
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

local function OpenWiki()
  vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
    pattern = "*.md",
    callback = function()
      vim.keymap.set({ 'n', 'v' }, '<CR>', Create_Open, { buffer = true })
    end
  })
  if vim.fn.filereadable(vim.fn.expand(vim.g.wiki_path .. 'index.md')) == 0 then
    vim.cmd('silent !mkdir -p ' .. vim.g.wiki_path)
    vim.cmd('silent !touch ' .. vim.g.wiki_path .. 'index.md')
  end
  vim.cmd('edit ' .. vim.g.wiki_path .. 'index.md')
end

return {
  OpenWiki = OpenWiki
}
