<h1 align="center">
  Personal Neovim Config“
</h1>

### Keyboard Shortcuts

`<leader> = <space>`

#### 1 Base
| Shortcut           | Action                                 | Mode |
|--------------------|----------------------------------------|------|
| `W`                | save file                              | n    |
| `Q`                | quit file                              | n    |
| `B`                | delete current buffer                  | n    |
| `N`                | :normal                                | v    |
| `Y`                | copy selected text to system clipboard | v    |
| `ca`               | copy full text to system clipboard     | n    |
| `<leader>sc`       | toggle spell check                     | n    |
| `<leader>sw`       | toggle wrap                            | n    |
| `<C-o>`            | escape from terminal input mode        | t    |
| `<leader><leader>` | move to the next placeholder `<++>`    | n, i |

#### 2 Move
| Shortcut | Action                          | Mode |
|----------|---------------------------------|------|
| `j`      | gj                              | n    |
| `k`      | gk                              | n    |
| `H`      | cursor to the start of the line | n    |
| `J`      | cursor down 10 terminal lines   | n    |
| `K`      | cursor up 10 terminal lines     | n    |
| `L`      | cursor to the end of the line   | n    |
| `<C-h>`  | `<left>`                        | i, c |
| `<C-j>`  | `<down>`                        | i, c |
| `<C-k>`  | `<up>`                          | i, c |
| `<C-l>`  | `<right>`                       | i, c |
| `s`      | quick jump                      | n，v |

#### 3 Panes
| Shortcut      | Action                                                                | Mode |
|---------------|-----------------------------------------------------------------------|------|
| `<leader>sh`  | create a new vertical split screen to the left of the current window  | n    |
| `<leader>sj`  | create a new split screen to the below of current window              | n    |
| `<leader>sk`  | create a new split screen to the above of current window              | n    |
| `<leader>sl`  | create a new vertical split screen to the right of the current window | n    |
| `<leader>smv` | rotate splits and arrange splits vertically                           | n    |
| `<leader>smh` | rotate splits and arrange splits horizontally                         | n    |
| `<C-h>`       | move cursor one window left                                           | n    |
| `<C-j>`       | move cursor one window down                                           | n    |
| `<C-k>`       | move cursor one window up                                             | n    |
| `<C-l>`       | move cursor one window right                                          | n    |

#### 4 Edit
| Shortcut     | Action                    | Mode |
|--------------|---------------------------|------|
| `S`          | add surround chars        | v    |
| `cs`         | change surround chars     | n    |
| `rs`         | remove surround chars     | n    |
| `<leader>ss` | quick substitute          | v    |
| `<leader>P`  | paste image based `xclip` | v    |

#### 5 Coding
##### 5.1 Base
| Shortcut     | Action                             | Mode |
|--------------|------------------------------------|------|
| `;f`         | formating code                     | n    |
| `<leader>cc` | comment code                       | n, v |
| `<Tab>`      | select next item                   | i, s |
| `<S-Tab>`    | select prev item                   | i, s |
| `<CR>`       | accept selected item               | i    |
| `<F5>`       | code running                       | n    |
| `<F10>`      | code running with center float win | n    |

##### 5.2 Lsp
| Shortcut     | Action                                     | Mode |
|--------------|--------------------------------------------|------|
| `<leader>pd` | peek definition with lspsaga               | n    |
| `<C-o>`      | edit selected definition                   | n    |
| `<C-v>`      | vsplit and edit selected definition        | n    |
| `<leader>pr` | peek references with telescope             | n    |
| `<leader>K`  | show hover doc with lspsaga                | n    |
| `<leader>rn` | rename selected variable name with lspsaga | n    |
| `<leader>ca` | show code action with lspsaga              | n    |
| `<leader>ot` | open outline with lspsaga                  | n    |
| `d[`         | goto diagnostics prev                      | n    |
| `d]`         | goto diagnostics next                      | n    |

#### 6 File Explorer
| Shortcut     | Action                               | Mode |
|--------------|--------------------------------------|------|
| `<leader>ra` | edit file                            | n    |
| `<leader>rh` | split left and edit file             | n    |
| `<leader>rj` | split bottom and edit file           | n    |
| `<leader>rk` | split top and edit file              | n    |
| `<leader>rl` | split right and edit file            | n    |
| `<leader>ff` | fuzzy search files with file name    | n    |
| `<leader>fw` | fuzzy search files with file content | n    |
| `<leader>fb` | fuzzy search files with buffer       | n    |
| `<leader>fo` | fuzzy search oldfiles                | n    |

#### 7 Git
| Shortcut     | Action                  | Mode |
|--------------|-------------------------|------|
| `g[`         | goto git prev hunk      | n    |
| `g]`         | goto git next hunk      | n    |
| `<leader>H`  | git preview hunk inline | n    |
| `<leader>gd` | git diffthis            | n    |
| `<leader>gr` | git reset hunk          | n    |

#### 8 Other tools
| Shortcut        | Action                                                             | Mode |
|-----------------|--------------------------------------------------------------------|------|
| `:Chdir`        | jump to the directory where the current buffer                     | n    |
| `:Chdir silent` | jump to the directory where the current buffer without notify      | n    |
| `<leader>ww`    | note manager                                                       | n    |
| `<cr>`          | create or enter note in wiki                                       | n    |
| `<c-f>`         | toggle float terminal if have not term, create it                  | n, t |
| `<c-r>`         | toggle float terminal positions(center/right)                      | t    |

### Plugin list
```shell
nvimdev/lspsaga.nvim
saghen/blink.cmp
nvim-treesitter/nvim-treesitter
nvim-treesitter/nvim-treesitter-textobjects
ibhagwan/fzf-lua
nvimdev/guard.nvim
lewis6991/gitsigns.nvim
nvimdev/indentmini.nvim
```


### Dependencies
```shell
bash-language-server
clang
lua
lua-language-server
luarocks
pyright
python
python-black
python-pynvim
shfmt
typescript-language-server
vim-language-server
vscode-css-languageserver
vscode-html-languageserver
vscode-json-languageserver
yazi
xclip
im-select #if use wsl
```

## Thanks
- [glepnir](https://github.com/glepnir/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)

---

### License MIT
