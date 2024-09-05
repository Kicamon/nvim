local function get_node()
  local ok, utils = pcall(require, 'nvim-treesitter.ts_utils')
  local node_cursor = utils.get_node_at_cursor()
  if ok and node_cursor ~= nil then
    vim.notify(node_cursor:type())
  end
end

local function get_cap_node()
  local cap_node = vim.treesitter.get_captures_at_cursor(0)
  vim.notify(vim.inspect(cap_node))
end

return {
  get_node = get_node,
  get_cap_node = get_cap_node,
}
