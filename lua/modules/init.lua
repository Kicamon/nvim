local conf = require('modules.config')
local P = {}

local function normalize_url(s)
  return s:match('^https?://') and s or 'https://github.com/' .. s
end

local function normalize_spec(spec)
  if type(spec) == 'string' then
    return normalize_url(spec)
  end
  if spec.src then
    return vim.tbl_extend('force', spec, { src = normalize_url(spec.src) })
  end
  return spec
end

local function ensure_list(specs)
  return (type(specs) == 'string' or (type(specs) == 'table' and specs.src)) and { specs } or specs
end

local function on_cmd(cmd, pkg_name, setup_fn)
  return function()
    vim.api.nvim_create_user_command(cmd, function(data)
      vim.api.nvim_del_user_command(cmd)
      vim.cmd.packadd(pkg_name)
      if setup_fn then
        setup_fn()
      end
      vim.cmd(('%s %s'):format(cmd, data.args))
    end, { nargs = '?' })
  end
end

local function on_event(events, pkg_name, setup_fn)
  return function()
    vim.api.nvim_create_autocmd(events, {
      once = true,
      callback = function()
        for _, p in ipairs(ensure_list(pkg_name)) do
          vim.cmd.packadd(p)
        end
        if setup_fn then
          setup_fn()
        end
      end,
    })
  end
end

function P:add(specs, opts)
  specs = vim.tbl_map(normalize_spec, ensure_list(specs))
  vim.pack.add(specs, vim.tbl_extend('keep', opts or {}, { confirm = false }))
  return self
end

P:add('nvimdev/lspsaga.nvim', {
  load = on_event('LspAttach', 'lspsaga.nvim', function()
    vim.cmd('redraw')
    conf.lspsaga()
  end),
})
P:add({ src = 'saghen/blink.cmp', version = vim.version.range('^1') }, {
  load = on_event('LspAttach', 'blink.cmp', function()
    conf.blink()
  end),
})
P:add({ src = 'nvim-treesitter/nvim-treesitter', version = 'main' }, {
  load = on_event({ 'BufReadPre', 'BufNewFile' }, 'nvim-treesitter', function()
    conf.treesitter()
  end),
})
P:add({ src = 'nvim-treesitter/nvim-treesitter-textobjects', version = 'main' }, { load = false })
P:add('ibhagwan/fzf-lua', {
  load = on_cmd('FzfLua', 'fzf-lua', function()
    require('fzf-lua').setup()
  end),
})
P:add('nvimdev/guard.nvim', {
  load = on_cmd('Guard', 'guard.nvim', function()
    conf.guard()
  end),
})
P:add('lewis6991/gitsigns.nvim', {
  load = on_event('BufRead', 'gitsigns.nvim', function()
    conf.gitsigens()
  end),
})
P:add('nvimdev/indentmini.nvim', {
  load = on_event('BufReadPre', 'indentmini.nvim', function()
    conf.indentmini()
  end),
})
