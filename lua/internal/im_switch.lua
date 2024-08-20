local input_toggle = 0

local switch = {
  en = 'fcitx5-remote -c',
  zh = 'fcitx5-remote -o',
  check = 'fcitx5-remote',
}

local function change_to_en()
  local input_status = tonumber(io.popen(switch.check):read('*all'))
  if input_status == 2 then
    input_toggle = 1
    vim.fn.system(switch.en)
  end
end

local function change_to_zh()
  local input_status = tonumber(io.popen(switch.check):read('*all'))
  if input_status ~= 2 and input_toggle == 1 then
    vim.fn.system(switch.zh)
    input_toggle = 0
  end
end

local md = {
  'language',
  'fenced_code_block_delimiter',
  'link_destination',
  'code_fence_content',
  'fenced_code_block',
  'latex_block',
}

local md_code = {
  'chunk', --lua
  'translation_unit', --c/cpp
  'module', --python
}

local function is_not_in_code_block() --markdown
  local ok, ts_utils = pcall(require, 'nvim-treesitter.ts_utils')
  if not ok then
    return true
  end
  local node_cursor = ts_utils.get_node_at_cursor()
  for _, node_type in ipairs(md) do
    if node_cursor and node_cursor:type() == node_type then
      return false
    end
  end
  while node_cursor do
    for _, node_type in ipairs(md_code) do
      if node_cursor and node_cursor:type() == node_type then
        return false
      end
    end
    node_cursor = node_cursor:parent()
  end
  return true
end

local function filetype_checke()
  if vim.bo.filetype == 'markdown' then
    return is_not_in_code_block()
  else
    return true
  end
end

return {
  change_to_en = change_to_en,
  change_to_zh = change_to_zh,
  filetype_checke = filetype_checke,
}
