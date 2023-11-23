local function Clear()
  if (vim.fn.filereadable('Makefile') == 1) then
    vim.cmd('silent ! make clean')
  else
    vim.cmd('silent ! rm -f "./%<" && rm -f "./%<"_*.txt')
  end
  vim.notify("󰆴 Clearn")
end

vim.keymap.set('n', 'rm', Clear, {})
