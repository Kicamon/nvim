local tools = {
  "Cursor",
  "CodeRunning",
  "GetNode",
  "TabToSpace",
  "Wiki",
  "Surround",
  "Wildfire",
  "Ranger",
  "QuickSubstitute",
  "ImSwitch",
  "Marks",
}

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    for _, v in ipairs(tools) do
      require("user.tool." .. v)
    end
  end
})
