local g = vim.g
g.mapleader = ' '
g.loaded_gzip = 1
g.loaded_tar = 1
g.loaded_tarPlugin = 1
g.loaded_zip = 1
g.loaded_zipPlugin = 1
g.loaded_getscript = 1
g.loaded_getscriptPlugin = 1
g.loaded_vimball = 1
g.loaded_vimballPlugin = 1
g.loaded_matchit = 1
g.loaded_matchparen = 1
g.loaded_2html_plugin = 1
g.loaded_logiPat = 1
g.loaded_rrhelper = 1
g.loaded_netrwPlugin = 1
_G.browser = 'chromium'
_G.lsp_fts = {
  'c',
  'cpp',
  'rust',
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
  Function = ' 󰡱 ',
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
