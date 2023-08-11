require("config.defaults")
require("config.keymaps")
require("config.plugins")

--vim.opt.runtimepath:append("$HOME/Documents/project/im-switch.nvim")

--require("im-switch").setup()

--local function getnode()
  --local ts_utils = require("nvim-treesitter.ts_utils")
  --local node_cursor = ts_utils.get_node_at_cursor()
  --vim.notify(node_cursor:type())
--end

--vim.keymap.set("n", "<leader>P", getnode, { noremap = true })
