local uv = vim.uv
local loded_list
local cmd_list = {}

local function wt()
  vim.g.workspace = vim.lsp.buf.list_workspace_folders()[1] or ''
  local work_tools_dir = vim.g.workspace .. '/.nvim'
  if not uv.fs_stat(work_tools_dir) or loded_list == work_tools_dir then
    return
  end

  for _, cmd in ipairs(cmd_list) do
    vim.api.nvim_del_user_command(cmd)
  end
  cmd_list = {}
  loded_list = work_tools_dir

  local handle = uv.fs_scandir(work_tools_dir)
  if handle then
    while true do
      local name, type = uv.fs_scandir_next(handle)
      if not name then
        break
      end
      if type == 'file' then
        local cmd = 'WT' .. name:sub(0, name:find('%.') - 1)
        table.insert(cmd_list, cmd)
        vim.api.nvim_create_user_command(cmd, function()
          dofile(work_tools_dir .. '/' .. name)
        end, { nargs = 0 })
      end
    end
  end
end

return { wt = wt }
