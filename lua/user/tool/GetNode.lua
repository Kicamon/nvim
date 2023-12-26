local function GetNode()
  local node_cursor = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  vim.notify(node_cursor:type())
end

vim.keymap.set("n", "<leader>N", GetNode, {})
