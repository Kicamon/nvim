local function tbl_hl(name, attr)
  vim.api.nvim_set_hl(0, "Simple_Tab" .. name, attr)
  return "Simple_Tab" .. name
end

local function getinfo(bufnr)
  return {
    file = vim.fn.bufname(bufnr),
    buftype = vim.fn.getbufvar(bufnr, '&buftype'),
    filetype = vim.fn.getbufvar(bufnr, '&filetype')
  }
end

local function devicon(bufnr, isSelected)
  local icon, devhl
  local info = getinfo(bufnr)
  local ok, devicons = pcall(require, 'nvim-web-devicons')
  if not ok then
    return ''
  end
  if info.buftype == 'terminal' then
    icon, devhl = devicons.get_icon_color_by_filetype('zsh', { default = true })
  else
    icon, devhl = devicons.get_icon_color_by_filetype(info.filetype, { default = true })
  end
  if icon then
    local attr = {
      fg = devhl,
    }
    local hl = tbl_hl(info.filetype, attr)
    local selectedHlStart = (isSelected and hl) and '%#' .. hl .. '#' or ''
    return selectedHlStart .. icon .. ' '
  end
  return ''
end

local function title(bufnr, isSelected)
  local name
  local info = getinfo(bufnr)

  if info.buftype == 'help' then
    name = 'help:' .. vim.fn.fnamemodify(info.file, ':t:r')
  elseif info.filetype == 'TelescopePrompt' then
    name = 'Telescope'
  elseif info.file == '' then
    name = '[No Name]'
  else
    name = vim.fn.pathshorten(vim.fn.fnamemodify(info.file, ':p:~:t'))
  end
  return (isSelected and '%#TabLineSel#' or '%#TabLine#') .. name
end

local function modified(bufnr)
  local modicon = vim.fn.getbufvar(bufnr, '&modified') == 1 and '●' or ''
  local hl = tbl_hl("modified", { fg = "#ff461f" })
  modicon = '%#' .. hl .. '#' .. modicon
  return modicon
end

local function cell(index)
  local isSelected = vim.fn.tabpagenr() == index
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]
  local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

  return hl .. '%' .. index .. 'T' .. ' ' ..
      devicon(bufnr, isSelected) ..
      title(bufnr, isSelected) .. ' ' ..
      modified(bufnr) .. '%T'
end

local tbl_rendera = coroutine.create(function()
  while true do
    local line = ''
    for i = 1, vim.fn.tabpagenr('$'), 1 do
      line = line .. cell(i)
    end
    line = line .. '%#TabLineFill#%='
    vim.opt.tabline = line
    coroutine.yield()
  end
end)

local function update(move)
  if move then
    vim.cmd(move .. 'tabmove')
  end
  vim.schedule(function()
    coroutine.resume(tbl_rendera)
  end)
end

return {
  update = update,
}
