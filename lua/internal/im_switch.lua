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

return {
  change_to_en = change_to_en,
  change_to_zh = change_to_zh,
  filetype_checke = filetype_checke,
}
