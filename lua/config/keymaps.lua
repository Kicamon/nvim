local mode_n    = { "n" }
local mode_v    = { "v" }
local mode_i    = { "i" }
local mode_t    = { "t" }
local mode_nv   = { "n", "v" }
local nmappings = {
  -- base
  { from = "W",                to = ":w<CR>",                                                      mode = mode_n  },
  { from = "Q",                to = ":q<CR>",                                                      mode = mode_n  },
  { from = "B",                to = ":bd<CR>",                                                     mode = mode_n  },
  { from = "N",                to = ":normal ",                                                    mode = mode_v  },
  { from = "Y",                to = "\"+y",                                                        mode = mode_v  },
  { from = "ca",               to = ":! xclip -sel c %<CR><CR>:lua vim.notify(\" Copied!\")<CR>", mode = mode_n  },
  { from = "<leader>sc",       to = ":set spell!<CR>",                                             mode = mode_n  },
  { from = "<leader>sw",       to = ":set wrap!<CR>",                                              mode = mode_n  },
  { from = "<leader><cr>",     to = ":noh<CR>",                                                    mode = mode_n  },
  { from = "<C-N>",            to = "<C-\\><C-N>",                                                 mode = mode_t  },
  { from = "<C-O>",            to = "<C-\\><C-N><C-O>",                                            mode = mode_t  },
  { from = "<leader><leader>", to = "/<++><CR>:noh<CR>\"_c4l",                                     mode = mode_n  },

  -- move
  { from = "j",                to = "gj",                                                          mode = mode_n  },
  { from = "k",                to = "gk",                                                          mode = mode_n  },
  { from = "H",                to = "0",                                                           mode = mode_nv },
  { from = "J",                to = "10j",                                                         mode = mode_n  },
  { from = "K",                to = "10k",                                                         mode = mode_n  },
  { from = "L",                to = "$",                                                           mode = mode_nv },
  { from = "<A-l>",            to = "<Right>",                                                     mode = mode_i  },
  { from = "<A-j>",            to = "<cmd>m .+1<cr>==",                                            mode = mode_n  },
  { from = "<A-k>",            to = "<cmd>m .-2<cr>==",                                            mode = mode_n  },
  { from = "<A-j>",            to = ":m '>+1<cr>gv=gv",                                            mode = mode_v  },
  { from = "<A-k>",            to = ":m '<-2<cr>gv=gv",                                            mode = mode_v  },

  -- windows splits
  { from = "s",                to = "<nop>",                                                                      },
  { from = "sh",               to = ":set nosplitright<CR>:vsplit<CR>",                            mode = mode_n  },
  { from = "sj",               to = ":set splitbelow<CR>:split<CR>",                               mode = mode_n  },
  { from = "sk",               to = ":set nosplitbelow<CR>:split<CR>",                             mode = mode_n  },
  { from = "sl",               to = ":set splitright<CR>:vsplit<CR>",                              mode = mode_n  },
  { from = "smv",              to = "<C-w>t<c-W>H",                                                mode = mode_n  },
  { from = "smh",              to = "<C-w>t<c-W>K",                                                mode = mode_n  },
  { from = "<leader>W",        to = "<c-w>w",                                                      mode = mode_n  },
  { from = "<leader>h",        to = "<c-w>h",                                                      mode = mode_n  },
  { from = "<leader>j",        to = "<c-w>j",                                                      mode = mode_n  },
  { from = "<leader>k",        to = "<c-w>k",                                                      mode = mode_n  },
  { from = "<leader>l",        to = "<c-w>l",                                                      mode = mode_n  },
  { from = "<up>",             to = ":res +5<CR>",                                                 mode = mode_n  },
  { from = "<down>",           to = ":res -5<CR>",                                                 mode = mode_n  },
  { from = "<left>",           to = ":vertical resize-5<CR>",                                      mode = mode_n  },
  { from = "<right>",          to = ":vertical resize+5<CR>",                                      mode = mode_n  },
  { from = "<leader>vim",      to = ":tabe ~/.config/nvim/init.lua<CR>",                           mode = mode_n  },

  -- buffers & tabs
  { from = "[b",               to = ":bp<CR>",                                                     mode = mode_n  },
  { from = "]b",               to = ":bn<CR>",                                                     mode = mode_n  },
  { from = "tu",               to = ":tabe<CR>",                                                   mode = mode_n  },
  { from = "tn",               to = ":+tabnext<CR>",                                               mode = mode_n  },
  { from = "tp",               to = ":-tabnext<CR>",                                               mode = mode_n  },
  { from = "gf",               to = "<C-w>gf",                                                     mode = mode_n  },
  { from = "tt",               to = ":20 Lex<CR>",                                                 mode = mode_n  },
}

local MdSnippets = {
  { from = "<Tab><Tab>",       to = "<Esc>/<++><CR>:nohlsearch<CR>\"_c4l",                         mode = mode_i  },
  { from = "<Tab><leader>",    to = "<Tab>",                                                       mode = mode_i  },
  { from = "《",               to = "《》<++><esc>F》i",                                           mode = mode_i  },
  { from = "》",               to = "> ",                                                          mode = mode_i  },
  { from = "（",               to = "（）<++><Esc>F）i",                                           mode = mode_i  },
  { from = "“",                to = "“”<++><Esc>F”i",                                              mode = mode_i  },
  { from = "”",                to = "“”<++><Esc>F”i",                                              mode = mode_i  },
  { from = "·n",               to = "---<Enter><Enter>",                                           mode = mode_i  },
  { from = "·b",               to = "****<++><Esc>F*hi",                                           mode = mode_i  },
  { from = "·s",               to = "~~~~<++><Esc>F~hi",                                           mode = mode_i  },
  { from = "·i",               to = "**<++><Esc>F*i",                                              mode = mode_i  },
  { from = "·d",               to = "``<++><Esc>F`i",                                              mode = mode_i  },
  { from = "·c",               to = "```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA",          mode = mode_i  },
  { from = "·m",               to = "- [ ] ",                                                      mode = mode_i  },
  { from = "·p",               to = "![](<++>)<++><Esc>F[a",                                       mode = mode_i  },
  { from = "·a",               to = "[](<++>)<++><Esc>F[a",                                        mode = mode_i  },
  { from = "·l",               to = "--- ",                                                        mode = mode_i  },
  { from = "·t",               to = "[toc]",                                                       mode = mode_i  },
  { from = "·1",               to = "#<Space><Enter><++><Esc>kA",                                  mode = mode_i  },
  { from = "·2",               to = "##<Space><Enter><++><Esc>kA",                                 mode = mode_i  },
  { from = "·3",               to = "###<Space><Enter><++><Esc>kA",                                mode = mode_i  },
  { from = "·4",               to = "####<Space><Enter><++><Esc>kA",                               mode = mode_i  },
  { from = "·5",               to = "#####<Space><Enter><++><Esc>kA",                              mode = mode_i  },
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    for _, mapping in ipairs(MdSnippets) do
      vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true, buffer = true })
    end
  end
})
