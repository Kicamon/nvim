local uv, api, fn = vim.uv, vim.api, vim.fn
local pack = {}
pack.__index = pack

function pack:boot_strap()
  self.data_path = fn.stdpath('data')
  self.config_path = fn.stdpath('config')
  ---@diagnostic disable-next-line: param-type-mismatch
  local lazy_path = vim.fs.joinpath(self.data_path, 'lazy', 'lazy.nvim')
  local state = uv.fs_stat(lazy_path)
  if not state then
    local cmd = '!git clone https://github.com/folke/lazy.nvim ' .. lazy_path
    api.nvim_command(cmd)
  end
  vim.opt.runtimepath:prepend(lazy_path)
  require('modules/package')
  require('lazy').setup(self.repos, {
    ---@diagnostic disable-next-line: param-type-mismatch
    lockfile = vim.fs.joinpath(self.data_path, 'lazy-lock.json'),
    dev = { path = '~/Documents/project/neovim' },
    ui = {
      border = 'rounded',
      size = {
        width = 0.8,
        height = 0.8,
      },
    },
  })
end

_G.packadd = function(repo)
  if not pack.repos then
    pack.repos = {}
  end

  pack.repos[#pack.repos + 1] = repo
end

return pack
