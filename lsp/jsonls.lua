return {
  cmd = { 'vscode-json-language-server', '--stdio' },
  filetypes = { 'json', 'jsonc' },
  init_options = {
    provideFormatter = true,
  },
  root_dir = function(fname)
    return vim.fs.dirname(vim.fs.find('.git', { path = fname, upward = true })[1])
  end,
  single_file_support = true,
}
