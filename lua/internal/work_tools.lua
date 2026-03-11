local uv, api = vim.uv, vim.api
local loded_dir
local cmd_list = {}

local function dofiles(conf, opt)
  local handle = uv.fs_scandir(conf.dir)
  if handle then
    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if type == 'file' and name:match('%.([^%.]+)$') == 'lua' then
        opt(conf, name)
      end
    end
  end
end

local function command(work_tools_dir_command)
  for _, cmd in ipairs(cmd_list) do
    api.nvim_del_user_command(cmd)
  end
  cmd_list = {}

  dofiles({ dir = work_tools_dir_command }, function(conf, name)
    local cmd = 'WT' .. name:sub(0, name:find('%.') - 1)
    table.insert(cmd_list, cmd)
    api.nvim_create_user_command(cmd, function()
      dofile(conf.dir .. '/' .. name)
    end, { nargs = 0 })
  end)
end

local function autocmd(work_tools_dir_autocmd)
  local group = vim.api.nvim_create_augroup('WTgroup', {})
  dofiles({ dir = work_tools_dir_autocmd, group = group }, function(conf, name)
    local autocmd_config = dofile(conf.dir .. '/' .. name)
    api.nvim_create_autocmd(autocmd_config.events, {
      group = conf.group,
      pattern = autocmd_config.pattern,
      callback = autocmd_config.func,
    })
  end)
end

local function wt()
  vim.g.workspace = vim.lsp.buf.list_workspace_folders()[1] or ''
  local work_tools_dir = vim.g.workspace .. '/.nvim'
  if not uv.fs_stat(work_tools_dir) or loded_dir == work_tools_dir then
    return
  end

  loded_dir = work_tools_dir

  command(work_tools_dir .. '/command')
  autocmd(work_tools_dir .. '/autocmd')
end

return { wt = wt }
