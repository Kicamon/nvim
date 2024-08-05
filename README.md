<h1 align="center">
  Neovim Config“
</h1>


![demo](./demo.png)

### Keyboard Shortcuts

`<leader> = <space>`

#### 1 Base
| Shortcut           | Action                                 | Mode |
|--------------------|----------------------------------------|------|
| `W`                | save file                              | n    |
| `Q`                | quit file                              | n    |
| `B`                | delete current buffer                  | n    |
| `N`                | :nomal                                 | v    |
| `Y`                | Copy selected text to system clipboard | v    |
| `ca`               | Copy full text to system clipboard     | n    |
| `<leader>sc`       | toggle spell check                     | n    |
| `<leader>sw`       | toggle wrap                            | n    |
| `<leader><cr>`     | nohlsearch                             | n    |
| `<C-n>`            | Escape from terminal input mode        | t    |
| `<leader><leader>` | Goto the next placeholder (<++>)       | n, i |

#### 2 Move
| Shortcut | Action                          | Mode |
|----------|---------------------------------|------|
| `j`      | gj                              | n    |
| `k`      | gk                              | n    |
| `H`      | Cursor to the start of the line | n    |
| `J`      | Cursor down 10 terminal lines   | n    |
| `K`      | Cursor up 10 terminal lines     | n    |
| `L`      | Cursor to the end of the line   | n    |
| `<C-l>`  | Move Cursor right               | i    |
| `s`      | Flash jump                      | n    |

#### 3 Panes and tmux
| Shortcut      | Action                                                                      | Mode |
|---------------|-----------------------------------------------------------------------------|------|
| `<leader>sh`  | Create a new vertical split screen and place it left to the current window  | n    |
| `<leader>sj`  | Create a new split screen and place it below to the current window          | n    |
| `<leader>sk`  | Create a new split screen and place it above to the current window          | n    |
| `<leader>sl`  | Create a new vertical split screen and place it right to the current window | n    |
| `<leader>smv` | Rotate splits and arrange splits vertically                                 | n    |
| `<leader>smh` | Rotate splits and arrange splits horizontally                               | n    |
| `<C-h>`       | Move cursor one window left                                                 | n    |
| `<C-j>`       | Move cursor one window down                                                 | n    |
| `<C-k>`       | Move cursor one window up                                                   | n    |
| `<C-l>`       | Move cursor one window right                                                | n    |

#### 4 Buffers and tabs
| Shortcut | Action            | Mode |
|----------|-------------------|------|
| `tn`     | Goto next tab     | n    |
| `tp`     | Goto previous tab | n    |
| `tmn`    | Move tab previous | n    |
| `tmp`    | Move tab next     | n    |
| `tt`     | Open file browser | n    |

#### 5 Edite
| Shortcut     | Action                     | Mode |
|--------------|----------------------------|------|
| `ga`         | Align chars                | v    |
| `S`          | Add surround chars         | v    |
| `cs`         | Change surround chars      | n    |
| `<leader>ts` | Replace all tab with space | n    |
| `<leader>ss` | Quick substitute           | v    |

#### 6 Codeing
| Shortcut     | Action               | Mode |
|--------------|----------------------|------|
| `;f`         | Formating code       | n    |
| `<leader>cc` | Comment code         | n, v |
| `<Tab>`      | Select next item     | i, s |
| `<S-Tab>`    | Select prev item     | i, s |
| `<CR>`       | Accept selected item | i    |
| `<F5>`       | Code runing          | n    |

##### 6.1 Lsp
| Shortcut     | Action                                     | Mode |
|--------------|--------------------------------------------|------|
| `<leader>pd` | Peek definition with lspsaga               | n    |
| `<C-o>`      | Edit selected definition                   | n    |
| `<C-v>`      | Vsplit and edit selected definition        | n    |
| `<leader>pr` | Peek references with telescope             | n    |
| `<leader>K`  | Show hover doc with lspsaga                | n    |
| `<leader>wa` | Add workspace folder                       | n    |
| `<leader>wr` | Remove workspace folder                    | n    |
| `<leader>wl` | List workspace folders                     | n    |
| `<leader>rn` | Rename selected variable name with lspsaga | n    |
| `<leader>ca` | Show code action with lspsaga              | n    |
| `<leader>ot` | Open outline with lspsaga                  | n    |
| `<leader>d[` | Goto diangostics prev                      | n    |
| `<leader>d]` | Goto diangostics next                      | n    |

##### 6.2 Competitest
| Shortcut | Action                     | Mode |
|----------|----------------------------|------|
| `:CP`    | Open competitest mode      | c    |
| `;rr`    | Running testcase           | n    |
| `;ra`    | Add testcase               | n    |
| `;re`    | Edit testcase              | n    |
| `;ri`    | Open competitive companion | n    |
| `;rd`    | Delete testcase            | n    |
| `;rm`    | Remove all testcase        | n    |

#### 7 File Explorer
| Shortcut     | Action                               | Mode |
|--------------|--------------------------------------|------|
| `<leader>ra` | Edit file                            | n    |
| `<leader>rh` | Split left and edit file             | n    |
| `<leader>rj` | Split bottom and edit file           | n    |
| `<leader>rk` | Split top and edit file              | n    |
| `<leader>rl` | Split right and edit file            | n    |
| `<leader>ff` | Fuzzy search files with file name    | n    |
| `<leader>fw` | Fuzzy search files with file content | n    |
| `<leader>b`  | Flaybuf                              | n    |

#### 8 Git
| Shortcut     | Action                  | Mode |
|--------------|-------------------------|------|
| `g[`         | Goto git prev hunk      | n    |
| `g]`         | Goto git next hunk      | n    |
| `<leader>H`  | Git preview hunk inline | n    |
| `<leader>gd` | Git diffthis            | n    |

#### 9 Other tools
| Shortcut     | Action                                                             | Mode |
|--------------|--------------------------------------------------------------------|------|
| `<leader>tr` | Translator                                                         | n    |
| `:Chdir`     | Jump to the directory where the current buffer                     | n    |
| `<leader>N`  | Get treesitter node in current                                     | n    |
| `<cr>`       | Quickly select the closest text object among a group of candidates | n    |
| `<leader>ww` | Note manager                                                       | n    |
| `<cr>`       | Create or enter note in wiki                                       | n    |


### Install
```shell
bash-language-server
clang
fd
lua
lua-language-server
pyright
python
python-black
python-pynvim
ripgrep
typescript-language-server
vscode-css-languageserver
vscode-html-languageserver
vscode-json-languageserver
vim-language-server
```

## Thanks
- [glepnir](https://github.com/glepnir/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)
- [nvimdev](https://github.com/nvimdev/modeline.nvim)
- [ellisonleao](https://github.com/ellisonleao/gruvbox.nvim)
- [m4xshen](https://github.com/m4xshen/autoclose.nvim)

---

### License MIT
