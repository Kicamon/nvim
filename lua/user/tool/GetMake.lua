local function GetMakefile()
  if (vim.bo.filetype == 'cpp') then
    vim.cmd('silent ! cp ~/.config/nvim/lua/user/Makefiles/Makefile_cpp ./Makefile')
  end
end

vim.keymap.set('n', '<leader>mk', GetMakefile, {})
