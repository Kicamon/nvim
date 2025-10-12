local api = vim.api

local function get_signs(name)
  return function()
    local bufnr = api.nvim_win_get_buf(vim.g.statusline_winid)
    local lnum = vim.v.lnum
    local it = vim
      .iter(
        api.nvim_buf_get_extmarks(
          bufnr,
          -1,
          { lnum - 1, 0 },
          { lnum - 1, -1 },
          { details = true, type = 'sign' }
        )
      )
      :find(function(item)
        return item[2] == vim.v.lnum - 1
          and item[4].sign_hl_group
          and item[4].sign_hl_group:find(name)
      end)
    return not it and '  ' or ('%%#%s#%s%%*'):format(it[4].sign_hl_group, it[4].sign_text)
  end
end

local function stc()
  local stc_diagnostic = get_signs('Diagnostic')
  local stc_gitsign = get_signs('GitSign')

  local function show_break()
    if vim.v.virtnum > 0 then
      return (' '):rep(math.floor(math.ceil(math.log10(vim.v.lnum))) - 1) .. '┆'
    end
    return vim.v.virtnum < 0 and '' or vim.v.lnum
  end
  return ('%s%%=%s%s'):format(stc_diagnostic(), show_break(), stc_gitsign())
end

return { stc = stc }
