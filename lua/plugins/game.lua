return {
  {
    "xeluxee/competitest.nvim",
    ft = { "cpp" },
    dependencies = {
      "MunifTanjim/nui.nvim",
    },

    config = function()
      require('competitest').setup()
      vim.keymap.set("n", "rr", "<cmd>CompetiTest run<CR>", { noremap = true })
      vim.keymap.set("n", "ra", "<cmd>CompetiTest add_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "re", "<cmd>CompetiTest edit_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "ri", "<cmd>CompetiTest receive testcases<CR>", { noremap = true })
      vim.keymap.set("n", "rd", "<cmd>CompetiTest delete_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "<leader>acm", "<cmd>CompetiTest receive contest<CR>", { noremap = true })
    end
  },
  {
    "Eandrju/cellular-automaton.nvim",
    event = 'VeryLazy',
    keys = "<leader>ga",
    config = function()
      vim.keymap.set("n", "<leader>ga", "<cmd>CellularAutomaton make_it_rain<CR>")
    end,
  },
}
