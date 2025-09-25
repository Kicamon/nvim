<h1 align="center">
  Personal Neovim Config“
</h1>

![demo](https://ice.frostsky.com/2024/09/19/08ca320f952cc6422dd6c0506fbd9afe.png)

### Keyboard Shortcuts

`<leader> = <space>`

#### 1 Base
| Shortcut           | Action                                 | Mode |
|--------------------|----------------------------------------|------|
| `W`                | save file                              | n    |
| `Q`                | quit file                              | n    |
| `B`                | delete current buffer                  | n    |
| `N`                | :nomal                                 | v    |
| `Y`                | copy selected text to system clipboard | v    |
| `ca`               | copy full text to system clipboard     | n    |
| `<leader>sc`       | toggle spell check                     | n    |
| `<leader>sw`       | toggle wrap                            | n    |
| `<leader><cr>`     | nohlsearch                             | n    |
| `<C-n>`            | escape from terminal input mode        | t    |
| `<leader><leader>` | goto the next placeholder `<++>`       | n, i |

#### 2 Move
| Shortcut | Action                          | Mode |
|----------|---------------------------------|------|
| `j`      | gj                              | n    |
| `k`      | gk                              | n    |
| `H`      | cursor to the start of the line | n    |
| `J`      | cursor down 10 terminal lines   | n    |
| `K`      | cursor up 10 terminal lines     | n    |
| `L`      | cursor to the end of the line   | n    |
| `<C-l>`  | move cursor right               | i    |
| `s`      | flash jump                      | n，v |

#### 3 Panes and tmux
| Shortcut      | Action                                                                      | Mode |
|---------------|-----------------------------------------------------------------------------|------|
| `<leader>sh`  | create a new vertical split screen and place it left to the current window  | n    |
| `<leader>sj`  | create a new split screen and place it below to the current window          | n    |
| `<leader>sk`  | create a new split screen and place it above to the current window          | n    |
| `<leader>sl`  | create a new vertical split screen and place it right to the current window | n    |
| `<leader>smv` | rotate splits and arrange splits vertically                                 | n    |
| `<leader>smh` | rotate splits and arrange splits horizontally                               | n    |
| `<C-h>`       | move cursor one window left                                                 | n    |
| `<C-j>`       | move cursor one window down                                                 | n    |
| `<C-k>`       | move cursor one window up                                                   | n    |
| `<C-l>`       | move cursor one window right                                                | n    |

#### 4 Edite
| Shortcut                      | Action                           | Mode |
|-------------------------------|----------------------------------|------|
| `S`                           | add surround chars               | v    |
| `cs`                          | change surround chars            | n    |
| `:Text tab_to_space`          | replace leading tabs with spaces | n    |
| `:Text delete_trailing_space` | delete trailing spaces           | n    |
| `<leader>ss`                  | quick substitute                 | v    |
| `<leader>P`                   | paste image under `x11`          | v    |

#### 5 Codeing
##### 5.1 Base
| Shortcut     | Action                            | Mode |
|--------------|-----------------------------------|------|
| `;f`         | formating code                    | n    |
| `<leader>cc` | comment code                      | n, v |
| `<Tab>`      | select next item                  | i, s |
| `<S-Tab>`    | select prev item                  | i, s |
| `<CR>`       | accept selected item              | i    |
| `<F5>`       | code runing                       | n    |
| `<F10>`      | code runing with center float win | n    |

![pkvTyD0.md.png](https://s21.ax1x.com/2024/08/05/pkvTyD0.md.png)

##### 5.2 Lsp
| Shortcut     | Action                                     | Mode |
|--------------|--------------------------------------------|------|
| `<leader>pd` | peek definition with lspsaga               | n    |
| `<C-o>`      | edit selected definition                   | n    |
| `<C-v>`      | vsplit and edit selected definition        | n    |
| `<leader>pr` | peek references with telescope             | n    |
| `<leader>K`  | show hover doc with lspsaga                | n    |
| `<leader>wa` | add workspace folder                       | n    |
| `<leader>wr` | remove workspace folder                    | n    |
| `<leader>wl` | list workspace folders                     | n    |
| `<leader>rn` | rename selected variable name with lspsaga | n    |
| `<leader>ca` | show code action with lspsaga              | n    |
| `<leader>ot` | open outline with lspsaga                  | n    |
| `<leader>d[` | goto diangostics prev                      | n    |
| `<leader>d]` | goto diangostics next                      | n    |

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

![yazi](https://s21.ax1x.com/2024/08/05/pkvTBgs.png)

#### 7 Git
| Shortcut     | Action                  | Mode |
|--------------|-------------------------|------|
| `g[`         | goto git prev hunk      | n    |
| `g]`         | goto git next hunk      | n    |
| `<leader>H`  | git preview hunk inline | n    |
| `<leader>gd` | git diffthis            | n    |

#### 8 Other tools
| Shortcut        | Action                                                             | Mode |
|-----------------|--------------------------------------------------------------------|------|
| `:Chdir`        | jump to the directory where the current buffer                     | n    |
| `:Chdir silent` | jump to the directory where the current buffer without notify      | n    |
| `<leader>N`     | get treesitter node in current                                     | n    |
| `<cr>`          | quickly select the closest text object among a group of candidates | n    |
| `<leader>ww`    | note manager                                                       | n    |
| `<cr>`          | create or enter note in wiki                                       | n    |
| `<c-f>`         | toggle float terminal if have not term, create it                  | n, t |
| `<c-p>`         | goto prev float terminal                                           | t    |
| `<c-n>`         | goto next float terminal                                           | t    |
| `<c-a>`         | add a float terminal                                               | t    |
| `<c-d>`         | delete a float terminal                                            | t    |
| `<c-r>`         | move float terminal right                                          | t    |
| `<c-c>`         | move float terminal center                                         | t    |

### Plugin list
```shell
blink.cmp
flash.nvim
fzf-lua
gitsigns.nvim
guard.nvim
indentmini.nvim
lspsaga.nvim
nvim-treesitter
```


### Dependencies
```shell
bash-language-server
clang
gopls
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
im-select #if use wsl
```

### TodoList
replace `vim.fn.termopen`

## Thanks
- [glepnir](https://github.com/glepnir/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)

---

### License MIT
