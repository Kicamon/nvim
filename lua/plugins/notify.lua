return {
  "rcarriga/nvim-notify",
  config = function()
    local notify = require("notify")
    vim.notify = notify
    notify.setup({
      background_colour = "#202020",
      fps = 60,
      level = 2,
      minimum_width = 50,
      render = "compact",
      stages = "slide",
      timeout = 3000,
      top_down = true
    })
  end
}
