local MdSnippets = {
  { from = "<c-j>", to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
  -- { from = ",n", to = "---<Enter><Enter>" },
  -- { from = ",b", to = "**** <++><Esc>F*hi" },
  -- { from = ",s", to = "~~~~ <++><Esc>F~hi" },
  -- { from = ",i", to = "** <++><Esc>F*i" },
  -- { from = ",d", to = "`` <++><Esc>F`i" },
  -- { from = ",c", to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>3kA" },
  -- { from = ",m", to = "- [ ] " },
  -- { from = ",p", to = "![](<++>) <++><Esc>F[a" },
  -- { from = ",a", to = "[](<++>) <++><Esc>F[a" },
  -- { from = ",1", to = "#<Space><Enter><++><Esc>kA" },
  -- { from = ",2", to = "##<Space><Enter><++><Esc>kA" },
  -- { from = ",3", to = "###<Space><Enter><++><Esc>kA" },
  -- { from = ",4", to = "####<Space><Enter><++><Esc>kA" },
  -- { from = ",5", to = "#####<Space><Enter><++><Esc>kA" },
  -- { from = ",l", to = "--- " },
  --中文
  { from = "《", to = "《》<++><Esc>F》i" },
  { from = "》", to = "> " },
  { from = "（", to = "（）<++><Esc>F）i" },
  { from = "“", to = "“”<++><Esc>F”i" },
  { from = "”", to = "“”<++><Esc>F”i" },
  { from = "<c-e>", to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l" },
  { from = "·w", to = "<Esc>/ <++><CR>:nohlsearch<CR>\"_c5l<CR>" },
  { from = "·b", to = "****<++><Esc>F*hi" },
  { from = "·s", to = "~~~~<++><Esc>F~hi" },
  { from = "·i", to = "**<++><Esc>F*i" },
  { from = "·d", to = "``<++><Esc>F`i" },
  { from = "·c", to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA" },
  { from = "·m", to = "- [ ] " },
  { from = "·n", to = "[^]<Esc>Go[^<++>]: <++><Esc><C-o>F^a" },
  { from = "·p", to = "![](<++>)<++><Esc>F[a" },
  { from = "·a", to = "[](<++>)<++><Esc>F[a" },
  { from = "·1", to = "#<Space><Enter><++><Esc>kA" },
  { from = "·2", to = "##<Space><Enter><++><Esc>kA" },
  { from = "·3", to = "###<Space><Enter><++><Esc>kA" },
  { from = "·4", to = "####<Space><Enter><++><Esc>kA" },
  { from = "·5", to = "#####<Space><Enter><++><Esc>kA" },
  { from = "·l", to = "--- " },
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { '*.md' },
  callback = function()
    for _, mapping in ipairs(MdSnippets) do
      vim.keymap.set("i", mapping.from, mapping.to, { noremap = true, buffer = true })
    end
  end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { '*.txt' },
  callback = function()
    vim.keymap.set("i", "<c-j>", "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l", { noremap = true, buffer = true })
  end
})
