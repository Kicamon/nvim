return {
  'nvimdev/epo.nvim',
  lazy = true,
  event = 'LspAttach',
  config = function()
    local kind_icons = {
      Text = " 󰉿 ",
      Method = " 󰆧 ",
      Function = " 󰊕 ",
      Constructor = "  ",
      Field = " 󰜢 ",
      Variable = " 󰀫 ",
      Class = " 󰠱 ",
      Interface = "  ",
      Module = "  ",
      Property = " 󰜢 ",
      Unit = " 󰑭 ",
      Value = " 󰎠 ",
      Enum = "  ",
      Keyword = " 󰌋 ",
      Snippet = "  ",
      Color = " 󰏘 ",
      File = " 󰈙 ",
      Reference = " 󰈇 ",
      Folder = " 󰉋 ",
      EnumMember = "  ",
      Constant = " 󰏿 ",
      Struct = " 󰙅 ",
      Event = "  ",
      Operator = " 󰆕 ",
      TypeParameter = " 󰅲 ",
    }
    vim.keymap.set('i', '<TAB>', function()
      if vim.fn.pumvisible() == 1 then
        return '<C-n>'
      elseif vim.snippet.jumpable(1) then
        return '<cmd>lua vim.snippet.jump(1)<cr>'
      else
        return '<TAB>'
      end
    end, { expr = true })

    vim.keymap.set('i', '<S-TAB>', function()
      if vim.fn.pumvisible() == 1 then
        return '<C-p>'
      elseif vim.snippet.jumpable(-1) then
        return '<cmd>lua vim.snippet.jump(-1)<CR>'
      else
        return '<S-TAB>'
      end
    end, { expr = true })

    vim.keymap.set('i', '<C-e>', function()
      if vim.fn.pumvisible() == 1 then
        require('epo').disable_trigger()
      end
      return '<C-e>'
    end, { expr = true })
    -- For using enter as completion, may conflict with some autopair plugin
    vim.keymap.set("i", "<cr>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-y>"
      end
      return "<cr>"
    end, { expr = true, noremap = true })

    -- nvim-autopair compatibility
    vim.keymap.set("i", "<cr>", function()
      if vim.fn.pumvisible() == 1 then
        return "<C-y>"
      end
      return require("nvim-autopairs").autopairs_cr()
    end, { expr = true, noremap = true })

    require('epo').setup({
      kind_format = function(k)
        return kind_icons[k] .. ' ' .. k
        -- return k:lower():sub(1, 1)
      end
    })
  end
}
