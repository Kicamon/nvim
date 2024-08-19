local api = vim.api

local function feedkeys(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local function open()
  local line = api.nvim_get_current_line()
  local path = string.match(line, '[^/]+(.-)%)')
  path = vim.fn.expand('%:p:~:h') .. path
  vim.cmd('edit ' .. path)
end

local function create()
  local tl, tr = vim.fn.getpos('v')[3], vim.fn.getpos('.')[3]
  local line = api.nvim_get_current_line()
  if line:sub(tr):find('[\227-\233\128-\191]') == 1 then
    tr = tr + 2
  end
  local file_name = string.sub(line, tl, tr)
  local file_link = './' .. string.gsub(file_name, ' ', '_') .. '.md'
  local line_front = tl == 1 and '' or string.sub(line, 1, tl - 1)
  local line_end = tr == #line and '' or string.sub(line, tr + 1)
  local line_mid = string.format('[%s](%s)', file_name, file_link)
  api.nvim_set_current_line(line_front .. line_mid .. line_end)
  feedkeys('<ESC>', 'n')
end

local function open_create()
  local node = require('nvim-treesitter.ts_utils').get_node_at_cursor()

  if node:type() == 'link_text' or node:type() == 'link_destination' then
    open()
  elseif node:type() == 'inline' then
    create()
  end
end

local function open_wiki()
  local index_path = '~/Documents/study/Note/wiki/index.md'
  local note_path = '~/Documents/study/Note/wiki'
  if vim.fn.filereadable(vim.fn.expand(index_path)) == 0 then
    vim.fn.jobstart('mkdir -p ' .. note_path .. '; touch' .. index_path)
  end
  vim.cmd('edit ' .. index_path)
end

return {
  open_wiki = open_wiki,
  open_create = open_create,
}
