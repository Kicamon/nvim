local TL = {}

function TL:TabList()
  local tab_opend = {}
  for index = 1, vim.fn.tabpagenr('$') do
    local _bufnr = vim.fn.tabpagebuflist(index)[vim.fn.tabpagewinnr(index)]
    local fname = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(_bufnr), ':p')
    table.insert(tab_opend, fname)
  end
  return tab_opend
end

function TL:TabOpend(filename, tab_opend)
  for idx, fname in ipairs(tab_opend) do
    if filename == fname then
      return idx
    end
  end
  return 0
end

return TL
