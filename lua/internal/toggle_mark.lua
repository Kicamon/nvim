local api = vim.api
local ns_id, mark_id = api.nvim_create_namespace('mark'), nil

local function toggle_mark()
  if not mark_id then
    local row, col = unpack(api.nvim_win_get_cursor(0))
    mark_id = api.nvim_buf_set_extmark(0, ns_id, row - 1, col, {
      virt_text = { { '⚑', 'DiagnosticError' } },
      hl_group = 'Search',
      virt_text_pos = 'inline',
    })
    return
  end
  local mark = api.nvim_buf_get_extmark_by_id(0, ns_id, mark_id, {})
  if not mark or #mark == 0 then
    return
  end
  pcall(api.nvim_win_set_cursor, 0, { mark[1] + 1, mark[2] })
  api.nvim_buf_del_extmark(0, ns_id, mark_id)
  mark_id = nil
end

return { toggle_mark = toggle_mark }
