local api, lsp = vim.api, vim.lsp
local pd = {}

local function get_stl_bg()
  local res = api.nvim_get_hl(0, { name = 'StatusLine' })
  if vim.tbl_isempty(res) then
    return
  end
  return res.bg
end

local stl_bg = get_stl_bg()
local function stl_attr(group)
  local color = api.nvim_get_hl(0, { name = group, link = false })
  return {
    bg = stl_bg,
    fg = color.fg,
  }
end

function pd.pad()
  return {
    stl = '%=',
    name = 'pad',
    attr = {
      background = 'NONE',
      foreground = 'NONE',
    },
  }
end

function pd.sep()
  return {
    stl = ' ',
    name = 'sep',
    attr = {
      background = 'NONE',
      foreground = 'NONE',
    },
  }
end

function pd.sepl()
  return {
    stl = ' \\ ',
    name = 'sepl',
    attr = {
      foreground = '#665c54',
    },
  }
end

function pd.sepr()
  return {
    stl = ' / ',
    name = 'sepr',
    attr = {
      foreground = '#665c54',
    },
  }
end

local function alias_mode()
  return {
    ['n'] = 'Normal',
    ['no'] = 'O-Pending',
    ['nov'] = 'O-Pending',
    ['noV'] = 'O-Pending',
    ['no\x16'] = 'O-Pending',
    ['niI'] = 'Normal',
    ['niR'] = 'Normal',
    ['niV'] = 'Normal',
    ['nt'] = 'Normal',
    ['ntT'] = 'Normal',
    ['v'] = 'Visual',
    ['vs'] = 'Visual',
    ['V'] = 'V-Line',
    ['Vs'] = 'V-Line',
    ['\x16'] = 'V-Block',
    ['\x16s'] = 'V-Block',
    ['s'] = 'Select',
    ['S'] = 'S-Line',
    ['\x13'] = 'S-Block',
    ['i'] = 'Insert',
    ['ic'] = 'Insert',
    ['ix'] = 'Insert',
    ['R'] = 'Replace',
    ['Rc'] = 'Replace',
    ['Rx'] = 'Replace',
    ['Rv'] = 'V-Replace',
    ['Rvc'] = 'V-Replace',
    ['Rvx'] = 'V-Replace',
    ['c'] = 'Command',
    ['cv'] = 'Ex',
    ['ce'] = 'Ex',
    ['r'] = 'Replace',
    ['rm'] = 'More',
    ['r?'] = 'Confirm',
    ['!'] = 'Shell',
    ['t'] = 'Terminal',
  }
end

function pd.mode()
  local alias = alias_mode()
  local result = {
    stl = function()
      local mode = api.nvim_get_mode().mode
      return alias[mode] or alias[string.sub(mode, 1, 1)] or 'UNK'
    end,
    name = 'mode',
    default = 'Normal',
    event = { 'ModeChanged', 'BufEnter', 'TermLeave' },
  }

  result.attr = stl_attr('StatusLineMode')
  result.attr.bold = true
  result.attr.italic = true

  return result
end

function pd.fileinfo()
  local result = {
    stl = '%t',
    name = 'fileinfo',
    event = { 'BufEnter' },
  }
  result.attr = stl_attr('StatusLineFileInfo')
  result.attr.bold = true
  result.attr.italic = true
  return result
end

function pd.modified()
  local result = {
    name = 'modified',
    stl = '%{&modified?"[+]":""}',
    event = { 'BufModifiedSet' },
  }
  result.attr = stl_attr('StatusLineFileInfo')
  return result
end

function pd.readonly()
  local result = {
    name = 'readonly',
    stl = '%{&readonly?"[-]":""}',
    event = { 'BufEnter' },
  }
  result.attr = stl_attr('StatusLineReadOnly')
  return result
end

local function gitsigns_data(git_t)
  local signs = {
    ['added'] = '+',
    ['changed'] = '~',
    ['removed'] = '-',
  }
  return function(args)
    local ok, dict = pcall(api.nvim_buf_get_var, args.buf, 'gitsigns_status_dict')
    if
      not ok
      or vim.tbl_isempty(dict)
      or not dict[git_t]
      or (type(dict[git_t]) == 'number' and dict[git_t] <= 0)
    then
      return ''
    end
    if git_t == 'head' and dict[git_t] == '' then
      local obj = vim
        .system({ 'git', 'config', '--get', 'init.defaultBranch' }, { text = true })
        :wait()
      if #obj.stdout > 0 then
        dict[git_t] = vim.trim(obj.stdout)
      end
    end
    if git_t == 'head' then
      return ('<%s>%s'):format(dict[git_t], ' ')
    end
    return ('%s%s%s'):format(signs[git_t], dict[git_t], ' ')
  end
end

function pd.gitinfo(git_t)
  local alias = {
    ['added'] = 'Add',
    ['changed'] = 'Change',
    ['removed'] = 'Delete',
  }
  local result = {
    stl = gitsigns_data(git_t),
    name = 'git' .. git_t,
    event = { 'User GitSignsUpdate', 'BufEnter' },
  }
  result.attr = stl_attr(git_t == 'head' and 'StatusLineBranch' or 'Diff' .. alias[git_t])
  result.attr.italic = true
  return result
end

function pd.progress()
  local spinner = { '⣶', '⣧', '⣏', '⡟', '⠿', '⢻', '⣹', '⣼' }
  local idx = 1
  return {
    stl = function(args)
      if args.data and args.data.params then
        local val = args.data.params.value
        if val.message or val.kind ~= 'end' then
          idx = idx + 1 > #spinner and 1 or idx + 1
          return spinner[idx - 1 > 0 and idx - 1 or 1] .. ' '
        end
      end
      return ''
    end,
    name = 'LspProgress',
    event = { 'LspProgress' },
    attr = stl_attr('String'),
  }
end

function pd.lsp()
  local result = {
    stl = function(args)
      local client = lsp.get_clients({ bufnr = args.buf })[1]
      if not client then
        return ''
      end
      local msg = client and client.name or ''
      if args.data and args.data.params then
        local val = args.data.params.value
        if not val.message or val.kind == 'end' then
          msg = client.name
        else
          msg = val.title
            .. ' '
            .. (val.message and val.message .. ' ' or '')
            .. (val.percentage and val.percentage .. '%' or '')
        end
      elseif args.event == 'BufEnter' then
        msg = client.name
      elseif args.event == 'LspDetach' then
        msg = ''
      end
      return '%-25.25{"' .. msg .. '"}'
    end,
    name = 'Lsp',
    event = { 'LspProgress', 'LspAttach', 'LspDetach', 'BufEnter' },
  }
  result.attr = stl_attr('StatusLineLsp')
  result.attr.bold = true
  result.attr.italic = true
  return result
end

function pd.recording()
  local function stl_recording()
    local stl = vim.fn.reg_recording()
    if stl ~= '' then
      stl = ' @' .. stl
    end
    return stl
  end
  local result = {
    stl = stl_recording,
    name = 'recording',
    attr = {
      fg = '#fabd2f',
    },
    event = { 'RecordingEnter', 'RecordingLeave' },
  }

  result.attr.bold = true

  return result
end

function pd.vnumber()
  local function stl_vnumber()
    local sl, sr = vim.fn.getpos('v')[2], vim.fn.getpos('v')[3]
    local el, er = vim.fn.getpos('.')[2], vim.fn.getpos('.')[3]
    local str = ''
    if sl == el then
      str = ' ' .. tostring(math.abs(sr - er) + 1)
    else
      str = ' ' .. tostring(math.abs(sl - el) + 1)
    end
    if vim.api.nvim_get_mode().mode ~= 'v' and vim.api.nvim_get_mode().mode ~= 'V' then
      str = ''
    end
    return str
  end
  local result = {
    stl = stl_vnumber,
    name = 'vnumber',
    attr = {
      fg = '#afd787',
    },
    event = { 'CursorMoved', 'ModeChanged' },
  }

  result.attr.bold = true

  return result
end

local function diagnostic_info(severity)
  return function()
    if not vim.diagnostic.is_enabled({ bufnr = 0 }) then
      return ''
    end
    -- local ns = api.nvim_get_namespaces()
    -- local key = vim.iter(ns):find(function(k)
    --   return k:find('diagnostic/signs')
    -- end)
    -- if not key then
    --   return ''
    -- end
    ---@diagnostic disable-next-line: param-type-mismatch
    local signs = vim.tbl_get(vim.diagnostic.config(), 'signs', 'text')
    local count = #vim.diagnostic.get(0, { severity = severity })
    return count > 0 and ' ' .. signs[severity] .. count or ''
  end
end

function pd.diagnostic(diag_t)
  return {
    stl = diagnostic_info(diag_t),
    name = 'diag' .. vim.diagnostic.severity[diag_t],
    event = { 'DiagnosticChanged', 'BufEnter' },
    attr = stl_attr('Diagnostic' .. vim.diagnostic.severity[diag_t]),
  }
end

function pd.filesize()
  local size_unit = { 'b', 'k', 'm', 'g' }
  local function get_size()
    local size = vim.fn.getfsize(vim.fn.expand('%'))
    local idx = 1
    while size >= 1024 and idx < #size_unit do
      size = size / 1024
      idx = idx + 1
    end
    vim.api.nvim_buf_get_name(0)
    return ('%.1f%s'):format(size, size_unit[idx])
  end
  local result = {
    stl = function()
      return get_size()
    end,
    name = 'filesize',
    default = get_size(),
    event = { 'BufEnter', 'BufModifiedSet' },
  }

  result.attr = stl_attr('StatusLineFilesize')
  result.attr.italic = true
  return result
end

function pd.encoding()
  local result = {
    stl = ('%s'):format(vim.o.ff .. ' ' .. vim.o.encoding),
    name = 'filencode',
    event = { 'RecordingEnter', 'RecordingLeave' },
  }

  result.attr = stl_attr('StatusLineEncoding')
  result.attr.italic = true
  return result
end

function pd.lnumcol()
  local result = {
    stl = '%P %-2.(%l:%c%)',
    name = 'linecol',
    event = { 'BufEnter' },
  }

  result.attr = stl_attr('StatlsLineLnum')
  result.attr.italic = true
  return result
end

return pd
