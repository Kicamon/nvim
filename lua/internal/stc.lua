local api = vim.api
local diagnostic_signs_temp

local function get_diagnostic_signs(bufnr, lnum)
  if vim.fn.mode() == 'i' then
    return diagnostic_signs_temp
  end
  local diagnostic = vim.diagnostic.get(bufnr, { lnum = lnum })
  if #diagnostic == 0 then
    diagnostic_signs_temp = '  '
  else
    diagnostic_signs_temp = ('%%#%s#%s%%*'):format(
      'Diagnostic' .. vim.diagnostic.severity[diagnostic[1].severity],
      diagnostic_signs[diagnostic[1].severity]
    )
  end
  return diagnostic_signs_temp
end

local function show_break(lnum, virtnum)
  if virtnum > 0 then
    return (' '):rep(math.floor(math.ceil(math.log10(lnum))) - 1) .. '┆'
  end
  return virtnum < 0 and '' or lnum
end

local function get_git_signs(bufnr, lnum)
  local mark = vim
    .iter(
      api.nvim_buf_get_extmarks(
        bufnr,
        -1,
        { lnum, 0 },
        { lnum, -1 },
        { details = true, type = 'sign' }
      )
    )
    :find(function(item)
      return item[2] == lnum and item[4].sign_hl_group and item[4].sign_hl_group:find('GitSign')
    end)
  return not mark and '  ' or ('%%#%s#%s%%*'):format(mark[4].sign_hl_group, mark[4].sign_text)
end

local function stc()
  local bufnr = api.nvim_win_get_buf(vim.g.statusline_winid)
  local lnum, virtnum = vim.v.lnum, vim.v.virtnum
  return ('%s%%=%s%s'):format(
    get_diagnostic_signs(bufnr, lnum - 1),
    show_break(lnum, virtnum),
    get_git_signs(bufnr, lnum - 1)
  )
end

return { stc = stc }
