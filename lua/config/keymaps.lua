local mode_nv = { "n", "v" }
local mode_n = { "n" }
local mode_v = { "v" }
local mode_i = { "i" }
local mode_t = { "t" }
local nmappings = {
	-- base
	{ from = "W",                   to = ":w<CR>",                                                        mode = mode_n  },
	{ from = "Q",                   to = ":q<CR>",                                                        mode = mode_n  },
	{ from = "B",                   to = ":bd<CR>",                                                       mode = mode_n  },
	{ from = "N",                   to = ":normal ",                                                      mode = mode_v  },
	{ from = "Y",                   to = "\"+y",                                                          mode = mode_v  },
	{ from = "ca",                  to = ":! xclip -sel c %<CR><CR>:lua vim.notify(\" Copied!\")<CR>",   mode = mode_n  },
	{ from = "<leader>sc",          to = ":set spell!<CR>",                                               mode = mode_n  },
	{ from = "<leader>sw",          to = ":set wrap!<CR>",                                                mode = mode_n  },
	{ from = "<leader><cr>",        to = ":noh<CR>",                                                      mode = mode_n  },
	{ from = "<C-N>",               to = "<C-\\><C-N>",                                                   mode = mode_t  },
	{ from = "<C-O>",               to = "<C-\\><C-N><C-O>",                                              mode = mode_t  },

	-- move
	{ from = "j",                   to = "gj",                                                            mode = mode_n  },
	{ from = "k",                   to = "gk",                                                            mode = mode_n  },
	{ from = "<A-l>",               to = "<Right>",                                                       mode = mode_i  },
	{ from = "<A-j>",               to = "<cmd>m .+1<cr>==",                                              mode = mode_n  },
	{ from = "<A-k>",               to = "<cmd>m .-2<cr>==",                                              mode = mode_n  },
	{ from = "<A-j>",               to = ":m '>+1<cr>gv=gv",                                              mode = mode_v  },
	{ from = "<A-k>",               to = ":m '<-2<cr>gv=gv",                                              mode = mode_v  },


	-- windows splits
	{ from = "s",                   to = "<nop>",                                                                        },
	{ from = "sh",                  to = ":set nosplitright<CR>:vsplit<CR>",                              mode = mode_n  },
	{ from = "sj",                  to = ":set splitbelow<CR>:split<CR>",                                 mode = mode_n  },
	{ from = "sk",                  to = ":set nosplitbelow<CR>:split<CR>",                               mode = mode_n  },
	{ from = "sl",                  to = ":set splitright<CR>:vsplit<CR>",                                mode = mode_n  },
	{ from = "smv",                 to = "<C-w>t<c-W>H",                                                  mode = mode_n  },
	{ from = "smh",                 to = "<C-w>t<c-W>K",                                                  mode = mode_n  },
	{ from = "<leader>h",           to = "<c-w>h",                                                        mode = mode_n  },
	{ from = "<leader>j",           to = "<c-w>j",                                                        mode = mode_n  },
	{ from = "<leader>k",           to = "<c-w>k",                                                        mode = mode_n  },
	{ from = "<leader>l",           to = "<c-w>l",                                                        mode = mode_n  },
	{ from = "<up>",                to = ":res +5<CR>",                                                   mode = mode_n  },
	{ from = "<down>",              to = ":res -5<CR>",                                                   mode = mode_n  },
	{ from = "<left>",              to = ":vertical resize-5<CR>",                                        mode = mode_n  },
	{ from = "<right>",             to = ":vertical resize+5<CR>",                                        mode = mode_n  },
	{ from = "<leader><leader>",    to = "/<++><CR>:noh<CR>\"_c4l",                                       mode = mode_n  },
	{ from = "<leader>vim",         to = ":tabe ~/.config/nvim/init.lua<CR>",                             mode = mode_n  },

	-- buffers & tabs
	{ from = "[b",                  to = ":bp<CR>",                                                       mode = mode_n  },
	{ from = "]b",                  to = ":bn<CR>",                                                       mode = mode_n  },
	{ from = "tu",                  to = ":tabe<CR>:lua MiniFiles.open()<CR>",                                         mode = mode_n  },
	{ from = "tn",                  to = ":+tabnext<CR>",                                                 mode = mode_n  },
	{ from = "tp",                  to = ":-tabnext<CR>",                                                 mode = mode_n  },
	{ from = "tmn",                 to = ":+tabmove<CR>",                                                 mode = mode_n  },
	{ from = "tmp",                 to = ":-tabmove<CR>",                                                 mode = mode_n  },
	{ from = "<A-1>",               to = "1gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-2>",               to = "2gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-3>",               to = "3gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-4>",               to = "4gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-5>",               to = "5gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-6>",               to = "6gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-7>",               to = "7gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-8>",               to = "8gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-9>",               to = "9gt<CR>",                                                       mode = mode_n  },
	{ from = "<A-0>",               to = "10gt<CR>",                                                      mode = mode_n  },
}

for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or "n", mapping.from, mapping.to, { noremap = true })
end

-- vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
--   pattern = "*",
--   callback = function()
--     local buffer_count = 0
--     for i = 1, vim.fn.bufnr('$') do
--       if vim.fn.buflisted(i) == 1 then
--         buffer_count = buffer_count + 1
--       end
--     end
--     if buffer_count == 1 then
--       vim.keymap.set("n", "Q", ":q<CR>", { noremap = true, buffer = true })
--     else
--       vim.keymap.set("n", "Q", ":bd<CR>", { noremap = true, buffer = true })
--     end
--   end
-- })
