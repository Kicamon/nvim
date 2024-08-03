local function check()
  local has_image = vim.fn.system("xclip -selection clipboard -t TARGETS -o")
  if has_image == nil then
    return false
  end
  local val = string.find(has_image, "image/png")
  if val == nil then
    return false
  end
  return true
end

local function paste()
  local path = vim.fn.expand("%:p:~:h")
  path = path .. "/img/"
  if vim.fn.isdirectory(path) == 0 then
    vim.cmd("silent !mkdir -p" .. path)
  end
  if check() then
    local imagename = vim.fn.input("Enter image name: ")
    vim.fn.system("xclip -selection clipboard -t image/png -o > " .. path .. imagename .. ".png")
    local row, col = unpack(vim.api.nvim_win_get_cursor(0))
    local line = vim.api.nvim_get_current_line()
    local line_before = string.sub(line, 0, col)
    local line_end = string.sub(line, col + 1)
    line = line_before .. "![](./img/" .. imagename .. ".png)" .. line_end
    vim.api.nvim_set_current_line(line)
    vim.api.nvim_win_set_cursor(0, { row, col + 2 })
    vim.cmd("startinsert")
  end
end

return {
  paste = paste
}
