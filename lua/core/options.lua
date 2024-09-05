local opt, api = vim.opt, vim.api
opt.termguicolors = true
opt.ttyfast = true
opt.cursorline = true
opt.wrap = false
opt.number = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.smartindent = true
opt.ignorecase = true
opt.smartcase = true
opt.ttimeoutlen = 0
opt.timeout = false
opt.showmode = false
opt.virtualedit = 'block'
opt.conceallevel = 0
opt.showtabline = 1
opt.laststatus = 3
opt.signcolumn = 'yes'
opt.breakindent = true
opt.spelloptions = 'camel'
opt.foldmethod = 'indent'
opt.foldlevel = 99
opt.winwidth = 25
opt.pumheight = 15
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.completeopt = 'menu,menuone,noselect,popup'
opt.fillchars = {
  stl = ' ',
  stlnc = '-',
  msgsep = ' ',
  foldopen = '',
  foldclose = '',
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}
opt.cmdheight = 0
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.colorcolumn = '0'
opt.undofile = true
opt.updatetime = 100
opt.redrawtime = 1500

local function get_signs(name)
  return function()
    local bufnr = api.nvim_win_get_buf(vim.g.statusline_winid)
    local it = vim
      .iter(api.nvim_buf_get_extmarks(bufnr, -1, 0, -1, { details = true, type = 'sign' }))
      :find(function(item)
        return item[2] == vim.v.lnum - 1
          and item[4].sign_hl_group
          and item[4].sign_hl_group:find(name)
      end)
    return not it and '  ' or ('%%#%s#%s%%*'):format(it[4].sign_hl_group, it[4].sign_text)
  end
end

function _G.show_stc()
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

opt.stc = '%!v:lua.show_stc()'
