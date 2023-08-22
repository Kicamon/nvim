return {
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-file-browser.nvim',
    },
    config = function()
      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})
      vim.keymap.set('n', '<leader>fw', builtin.current_buffer_fuzzy_find, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fg', builtin.git_status, {})
      --vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>fz', builtin.spell_suggest, {})
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      telescope.setup {
        defaults = {
          mappings = {
            i = {
              ["<CR>"] = actions.file_tab
            },
            n = {
              ["l"] = actions.file_tab
            },
          }
        },
      }
    end
  },
}
