local conf = require('modules.config')

local function to_url(s)
  return s:match('^https?://') and s or 'https://github.com/' .. s
end

local function to_name(s)
  return s:sub(s:find('/') + 1)
end

local function load(pkg_name, events, cmd, config)
  if not config then
    return false
  end
  return function()
    if events then
      vim.api.nvim_create_autocmd(events, {
        once = true,
        callback = function()
          vim.cmd.packadd(pkg_name)
          if config then
            config()
          end
        end,
      })
    end
    if cmd then
      vim.api.nvim_create_user_command(cmd, function(data)
        vim.api.nvim_del_user_command(cmd)
        vim.cmd.packadd(pkg_name)
        if config then
          config()
        end
        vim.cmd(('%s %s'):format(cmd, data.args))
      end, { nargs = '?' })
    end
  end
end

local function get_pack_info(info, version)
  local pkg_name = to_name(info)
  local pkg_url
  if version then
    pkg_url = { {
      src = to_url(info),
      version = version,
    } }
  else
    pkg_url = { to_url(info) }
  end

  return pkg_name, pkg_url
end

local function packadd(info)
  local pkg_name, pkg_url = get_pack_info(info[1], info.version)
  vim.pack.add(
    pkg_url,
    vim.tbl_extend(
      'keep',
      { load = load(pkg_name, info.events, info.cmd, info.config) } or {},
      { confirm = false }
    )
  )
end

packadd({
  'nvimdev/lspsaga.nvim',
  events = 'BufReadPre',
  config = conf.lspsaga,
})

packadd({
  'saghen/blink.cmp',
  version = vim.version.range('^1'),
  events = 'LspAttach',
  config = conf.blink,
})

packadd({
  'nvim-treesitter/nvim-treesitter',
  version = 'main',
  events = 'BufReadPre',
  config = conf.treesitter,
})

packadd({
  'nvim-treesitter/nvim-treesitter-textobjects',
  version = 'main',
})

packadd({
  'ibhagwan/fzf-lua',
  cmd = 'FzfLua',
})

packadd({
  'nvimdev/guard.nvim',
  cmd = 'Guard',
  config = conf.guard,
})

packadd({
  'lewis6991/gitsigns.nvim',
  events = 'BufRead',
  config = conf.gitsigens,
})

packadd({
  'nvimdev/indentmini.nvim',
  events = 'BufReadPre',
  config = conf.indentmini,
})
