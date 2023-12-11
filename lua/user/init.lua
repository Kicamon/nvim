local tools = {
  "Cursor",
  "CodeRunning",
  "GetMake",
  "Clear",
  "GetNode",
  "TabToSpace",
  "Wiki",
  "Surround",
  "Wildfire",
  "Ranger",
  "QuickSubstitute",
  "ImSwitch",
}

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    for _, v in ipairs(tools) do
      require("user.tool." .. v)
    end
  end
})
