vim.schedule(function()
  -- lsp config
  local config_dir = vim.fn.stdpath('config') .. '/lsp'

  local config_files = vim.fn.glob(config_dir .. '/*.lua', false, true)
  local servers = {}

  for _, file in ipairs(config_files) do
    local server_name = vim.fn.fnamemodify(file, ':t:r')
    table.insert(servers, server_name)
  end

  vim.lsp.enable(servers)

  -- diagnostic config
  vim.diagnostic.config({
    virtual_text = {
      prefix = '❯',
    },
  })

  vim.diagnostic.config({
    signs = {
      text = diagnostic_signs,
    },
    float = {
      border = 'rounded',
    },
  })
end)
