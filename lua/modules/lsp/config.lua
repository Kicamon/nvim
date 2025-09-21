local config = {}

function config.lspsaga()
  require('lspsaga').setup({
    ui = {
      devicon = false,
      border = 'single',
    },
    outline = {
      keys = {
        toggle_or_jump = '<cr>',
      },
    },
    finder = {
      keys = {
        edit = '<C-o>',
        toggle_or_open = '<cr>',
      },
    },
    definition = {
      keys = {
        edit = '<C-o>',
        vsplit = '<C-v>',
      },
    },
  })
end

return config
