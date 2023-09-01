return {
  {
    "xeluxee/competitest.nvim",
    ft = { "cpp" },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },

    config = function()
      local Job = require("plenary.job")
      local output = {}
      local submit = Job:new({
        command = "cf",
        args = { "submit" },
        cwd = "./",
        on_stdout = function(_, data)
          table.insert(output, data)
          --vim.notify(data)
        end,
        on_exit = function(_, _)
          if output then
            local stdout = ""
            local len = #output
            for i = len - 2, len do
              stdout = stdout .. '\n' .. output[i]
            end
            --local stdout = table.concat(output, '\n')
            vim.notify(stdout)
          end
        end
      })
      local function Submit()
        vim.notify("Submit")
        submit:start()
      end
      require('competitest').setup()
      vim.keymap.set("n", "rr", "<cmd>CompetiTest run<CR>", { noremap = true })
      vim.keymap.set("n", "ra", "<cmd>CompetiTest add_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "re", "<cmd>CompetiTest edit_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "ri", "<cmd>CompetiTest receive testcases<CR>", { noremap = true })
      vim.keymap.set("n", "rd", "<cmd>CompetiTest delete_testcase<CR>", { noremap = true })
      vim.keymap.set("n", "rp", Submit, { noremap = true, silent = true })
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
