return {
  root_dir = function(fname)
    return require('lspconfig').util.root_pattern(unpack({
      '.pyproject.toml',
      'main.py',
      '.git',
    }))(fname) or require('lspconfig').util.find_git_ancestor(fname)
  end,
  single_file_support = true,
}
