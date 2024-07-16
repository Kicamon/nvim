local function GetNode()
  local ok, utils = pcall(require, 'nvim-treesitter.ts_utils')
  local node_cursor = utils.get_node_at_cursor()
  if ok and node_cursor ~= nil then
    vim.notify(node_cursor:type())
  end
end

return {
  GetNode = GetNode
}

