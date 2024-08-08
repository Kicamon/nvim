local g = vim.g
g.mapleader = ' '
g.netrw_browse_split = 0
g.netrw_liststyle = 3
g.netrw_banner = 0
_G.browser = 'chromium'
_G.wiki_path = '~/Documents/study/Note/wiki/'
_G.fts = {
  'c',
  'cpp',
  'lua',
  'python',
  'javascript',
  'typescript',
  'json',
  'html',
  'css',
  'vim',
  'sh',
}
_G.kind_icons = {
  Text = ' 󰉿 ',
  Method = ' 󰆧 ',
  Function = ' 󰊕 ',
  Constructor = '  ',
  Field = ' 󰜢 ',
  Variable = ' 󰀫 ',
  Class = ' 󰠱 ',
  Interface = '  ',
  Module = '  ',
  Property = ' 󰜢 ',
  Unit = ' 󰑭 ',
  Value = ' 󰎠 ',
  Enum = '  ',
  Keyword = ' 󰌋 ',
  Snippet = '  ',
  Color = ' 󰏘 ',
  File = ' 󰈙 ',
  Reference = ' 󰈇 ',
  Folder = ' 󰉋 ',
  EnumMember = '  ',
  Constant = ' 󰏿 ',
  Struct = ' 󰙅 ',
  Event = '  ',
  Operator = ' 󰆕 ',
  TypeParameter = ' 󰅲 ',
}
require('core.options')
require('core.pack'):boot_strap()
