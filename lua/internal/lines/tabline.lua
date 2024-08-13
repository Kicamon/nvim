local function tbl_hl(name, attr)
  vim.api.nvim_set_hl(0, 'Simple_Tab' .. name, attr)
  return 'Simple_Tab' .. name
end

local function getinfo(bufnr)
  return {
    file = vim.fn.bufname(bufnr),
    buftype = vim.fn.getbufvar(bufnr, '&buftype'),
    filetype = vim.fn.getbufvar(bufnr, '&filetype'),
  }
end

local function title(bufnr, isSelected)
  local name
  local info = getinfo(bufnr)

  if info.file == '' then
    name = '[No Name]'
  else
    name = vim.fn.pathshorten(vim.fn.fnamemodify(info.file, ':p:~:t'))
  end
  return (isSelected and '%#TabLineSel#' or '%#TabLine#') .. name
end

local function modified(bufnr)
  local modicon = vim.fn.getbufvar(bufnr, '&modified') == 1 and '●' or ''
  local hl = tbl_hl('modified', { fg = '#ff461f' })
  modicon = '%#' .. hl .. '#' .. modicon
  return modicon
end

local function cell(index)
  local isSelected = vim.fn.tabpagenr() == index
  local buflist = vim.fn.tabpagebuflist(index)
  local winnr = vim.fn.tabpagewinnr(index)
  local bufnr = buflist[winnr]
  local hl = (isSelected and '%#TabLineSel#' or '%#TabLine#')

  return hl
    .. '%'
    .. index
    .. 'T'
    .. ' '
    .. title(bufnr, isSelected)
    .. ' '
    .. modified(bufnr)
    .. '%T'
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
