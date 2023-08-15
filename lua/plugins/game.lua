return {
  "Eandrju/cellular-automaton.nvim",
  keys = "<leader>ga",
  config = function()
    vim.keymap.set("n", "<leader>ga", "<cmd>CellularAutomaton make_it_rain<CR>")
  end,
}
