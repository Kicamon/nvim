local api = vim.api
local get_visual_pos = require('internal.util.get_surround').visual

local function feedkeys(keys, mode)
  api.nvim_feedkeys(api.nvim_replace_termcodes(keys, true, true, true), mode, true)
end

local defualt_word_map = {
  ['true'] = 'false',
  ['True'] = 'False',
  ['TRUE'] = 'FALSE',
  ['false'] = 'true',
  ['False'] = 'True',
  ['FALSE'] = 'TRUE',
  ['yes'] = 'no',
  ['Yes'] = 'No',
  ['YES'] = 'NO',
  ['no'] = 'yes',
  ['No'] = 'Yes',
  ['NO'] = 'YES',
  ['on'] = 'off',
  ['On'] = 'Off',
  ['ON'] = 'OFF',
  ['off'] = 'on',
  ['Off'] = 'On',
  ['OFF'] = 'ON',
  ['max'] = 'min',
  ['Max'] = 'Min',
  ['MAX'] = 'MIN',
  ['min'] = 'max',
  ['Min'] = 'Max',
  ['MIN'] = 'MAX',
  ['and'] = 'or',
  ['And'] = 'Or',
  ['AND'] = 'OR',
  ['or'] = 'and',
  ['Or'] = 'And',
  ['OR'] = 'AND',
  ['+'] = '-',
  ['+='] = '-=',
  ['-'] = '+',
  ['-='] = '+=',
  ['<'] = '>',
  ['>'] = '<',
  ['=='] = '!=',
  ['!='] = '==',
  ['<='] = '>=',
  ['>='] = '<=',
  ['&'] = '|',
  ['&&'] = '||',
  ['&='] = '|=',
  ['|'] = '&',
  ['||'] = '&&',
  ['|='] = '&=',
}

local function get_word_map()
  local word_map
  local filetype = vim.bo.filetype
  local special_map = {}

  if filetype == 'lua' then
    special_map = {
      ['=='] = '~=',
      ['~='] = '==',
    }
  end

  word_map = vim.tbl_extend('force', defualt_word_map, special_map or {})

  return word_map
end

---get the cursor word's position
---@return string old word
---@return integer start col
---@return integer end col
local function get_cursor_word_pos()
  vim.cmd('normal! viw')
  local _, sr, _, er = get_visual_pos()
  feedkeys('<esc>', 'n')

  local word = string.sub(api.nvim_get_current_line(), sr, er)

  return word, sr, er
end

---modify the word
---@param sr integer
---@param er integer
---@param word string
local function change_line(sr, er, word)
  local line = api.nvim_get_current_line()
  local line_front = string.sub(line, 1, sr - 1)
  local line_back = string.sub(line, er + 1)
  api.nvim_set_current_line(line_front .. word .. line_back)
end

local function invert_word()
  local cursor = api.nvim_win_get_cursor(0)
  local old_word, sr, er = get_cursor_word_pos()
  local word_map = get_word_map()

  if word_map[old_word] then
    change_line(sr, er, word_map[old_word])
  else
    vim.notify('Unsupported word\n', vim.log.levels.INFO)
  end
  api.nvim_win_set_cursor(0, cursor)
end

return { invert_word = invert_word }
