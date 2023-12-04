local Win = require("user.FloatWin")

local function FloatWin(opt, args)
  local width, height = 0.7, 0.7
  if args then
    local splitc = args:find(' ')
    if splitc then
      width, height = tonumber(args:sub(1, splitc - 1)), tonumber(args:sub(splitc + 1))
    end
  end
  Win:Create({
    width = width,
    height = height,
  })
  if opt.cmd then
    vim.cmd(opt.cmd)
  end
end

vim.api.nvim_create_user_command(
  'FloatWin',
  function(opt)
    FloatWin({}, opt.args)
  end,
  { nargs = '?' }
)

vim.api.nvim_create_user_command(
  'FloatTerm',
  function(opt)
    FloatWin({ cmd = 'term'}, opt.args)
  end,
  { nargs = '?' }
)
