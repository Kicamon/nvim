local api = vim.api
local note_path = '~/Documents/study/Note/'
local index_path = note_path .. 'README.md'

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
  local sc, ec = vim.fn.getpos('v')[3], vim.fn.getpos('.')[3]
  local line = api.nvim_get_current_line()
  if line:sub(ec):find('[\227-\233\128-\191]') == 1 then
    ec = ec + 2
  end
  local file_name = string.sub(line, sc, ec)
  local file_link = './' .. string.gsub(file_name, ' ', '_') .. '.md'
  local line_front = string.sub(line, 1, sc - 1)
  local line_end = string.sub(line, ec + 1)
  local line_mid = string.format('[%s](%s)', file_name, file_link)
  api.nvim_set_current_line(line_front .. line_mid .. line_end)
  feedkeys('<ESC>', 'n')
end

local function open_create()
  local node_cursor = vim.treesitter.get_captures_at_cursor(0)

  for _, v in pairs(node_cursor) do
    if string.find(v, 'markup.link') then
      open()
      return
    end
  end

  if vim.fn.mode() ~= 'v' then
    vim.cmd('normal! viw')
  end
  create()
end

local function open_wiki()
  if vim.fn.filereadable(vim.fn.expand(index_path)) == 0 then
    vim.fn.jobstart(string.format('mkdir -p %s; touch %s', note_path, index_path))
  end
  vim.cmd.edit(index_path)
end

return {
  open_wiki = open_wiki,
  open_create = open_create,
}
