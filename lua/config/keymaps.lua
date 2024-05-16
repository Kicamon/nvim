local nmappings  = {
  { from = 'W',                to = '<cmd>w<CR>',                            mode = { 'n' },      opts = { noremap = true } },
  { from = 'Q',                to = '<cmd>q<CR>',                            mode = { 'n' },      opts = { noremap = true } },
  { from = 'B',                to = '<cmd>bd<CR>',                           mode = { 'n' },      opts = { noremap = true } },
  { from = 'N',                to = ':normal ',                              mode = { 'v' },      opts = { noremap = true } },
  { from = 'Y',                to = '"+y',                                   mode = { 'v' },      opts = { noremap = true } },
  { from = 'ca',               to = '<cmd>silent %y+<CR>',                   mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader>sc',       to = '<cmd>set spell!<CR>',                   mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader>sw',       to = '<cmd>set wrap!<CR>',                    mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader><cr>',     to = '<cmd>noh<CR>',                          mode = { 'n' },      opts = { noremap = true } },
  { from = '<C-N>',            to = '<C-\\><C-N>',                           mode = { 't' },      opts = { noremap = true } },
  { from = '<C-O>',            to = '<C-\\><C-N><C-O>',                      mode = { 't' },      opts = { noremap = true } },
  { from = '<leader><leader>', to = '/<++><CR>:noh<CR>"_c4l',                mode = { 'n' },      opts = { noremap = true } },
  { from = 'j',                to = 'gj',                                    mode = { 'n' },      opts = { noremap = true } },
  { from = 'k',                to = 'gk',                                    mode = { 'n' },      opts = { noremap = true } },
  { from = 'H',                to = '0',                                     mode = { 'n', 'v' }, opts = { noremap = true } },
  { from = 'J',                to = '<c-d>',                                 mode = { 'n' },      opts = { noremap = true } },
  { from = 'K',                to = '<c-u>',                                 mode = { 'n' },      opts = { noremap = true } },
  { from = 'L',                to = '$',                                     mode = { 'n', 'v' }, opts = { noremap = true } },
  { from = '<C-l>',            to = '<Right>',                               mode = { 'i' },      opts = { noremap = true } },
  { from = 'sh',               to = '<cmd>set nosplitright<CR>:vsplit<CR>',  mode = { 'n' },      opts = { noremap = true } },
  { from = 'sj',               to = '<cmd>set splitbelow<CR>:split<CR>',     mode = { 'n' },      opts = { noremap = true } },
  { from = 'sk',               to = '<cmd>set nosplitbelow<CR>:split<CR>',   mode = { 'n' },      opts = { noremap = true } },
  { from = 'sl',               to = '<cmd>set splitright<CR>:vsplit<CR>',    mode = { 'n' },      opts = { noremap = true } },
  { from = 'smv',              to = '<C-w>t<c-W>H',                          mode = { 'n' },      opts = { noremap = true } },
  { from = 'smh',              to = '<C-w>t<c-W>K',                          mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader>W',        to = '<c-w>w',                                mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader>vim',      to = '<cmd>edit ~/.config/nvim/init.lua<CR>', mode = { 'n' },      opts = { noremap = true } },
  { from = 'tn',               to = '<cmd>tabnext<CR>',                      mode = { 'n' },      opts = { noremap = true } },
  { from = 'tp',               to = '<cmd>tabprevious<CR>',                  mode = { 'n' },      opts = { noremap = true } },
  { from = 'tu',               to = '<cmd>tabnew<CR>',                       mode = { 'n' },      opts = { noremap = true } },
  { from = 'tt',               to = '<cmd>silent 20 Lex<CR>',                mode = { 'n' },      opts = { noremap = true } },
  { from = '<leader>cc',       to = 'gcc',                                   mode = { 'n' },      opts = { remap = true } },
  { from = '<leader>cc',       to = 'gc',                                    mode = { 'v' },      opts = { remap = true } },
}

local MdSnippets = {
  { from = '<Tab><Tab>',       to = '<Esc>/<++><CR>:nohlsearch<CR>"_c4l',                 mode = { 'i' } },
  { from = '<Tab><leader>',    to = '<Tab>',                                              mode = { 'i' } },
  { from = '《',               to = '《》<Esc>i',                                         mode = { 'i' } },
  { from = '》',               to = '> ',                                                 mode = { 'i' } },
  { from = '（',               to = '（）<Esc>i',                                         mode = { 'i' } },
  { from = '“',                to = '“”<Esc>i',                                           mode = { 'i' } },
  { from = '”',                to = '“”<Esc>i',                                           mode = { 'i' } },
  { from = '·b',               to = '****<++><Esc>F*hi',                                  mode = { 'i' } },
  { from = '·s',               to = '~~~~<++><Esc>F~hi',                                  mode = { 'i' } },
  { from = '·i',               to = '**<++><Esc>F*i',                                     mode = { 'i' } },
  { from = '·d',               to = '``<++><Esc>F`i',                                     mode = { 'i' } },
  { from = '·c',               to = '```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA', mode = { 'i' } },
  { from = '·m',               to = '- [ ] ',                                             mode = { 'i' } },
  { from = '·p',               to = '![](<++>)<++><Esc>F[a',                              mode = { 'i' } },
  { from = '·a',               to = '[](<++>)<++><Esc>F[a',                               mode = { 'i' } },
  { from = '·l',               to = '--- ',                                               mode = { 'i' } },
  { from = '·t',               to = '[toc]',                                              mode = { 'i' } },
  { from = '·1',               to = '#<Space><Enter><++><Esc>kA',                         mode = { 'i' } },
  { from = '·2',               to = '##<Space><Enter><++><Esc>kA',                        mode = { 'i' } },
  { from = '·3',               to = '###<Space><Enter><++><Esc>kA',                       mode = { 'i' } },
  { from = '·4',               to = '####<Space><Enter><++><Esc>kA',                      mode = { 'i' } },
  { from = '·5',               to = '#####<Space><Enter><++><Esc>kA',                     mode = { 'i' } },
}


for _, mapping in ipairs(nmappings) do
  vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, mapping.opts)
end

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '*.md',
  callback = function()
    for _, mapping in ipairs(MdSnippets) do
      vim.keymap.set(mapping.mode or 'n', mapping.from, mapping.to, { noremap = true, buffer = true })
    end
  end
})
