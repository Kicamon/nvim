local function GetNode()
  local node_cursor = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  while node_cursor do
    vim.notify(node_cursor:type())
    node_cursor = node_cursor:parent()
  end
  return true
end

vim.keymap.set("n", "<leader>P", GetNode, {})
