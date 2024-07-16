local function preview()
  vim.fn.jobstart('typora "' .. vim.fn.expand("%") .. '"')
  vim.api.nvim_set_option_value('autoread', true, { buf = 0 })
end

return {
  MarkdownPreview = preview
}
