<h1 align="center">
  Personal Neovim Config“
</h1>


![demo](https://s21.ax1x.com/2024/08/05/pkvTa4g.png)

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

#### 4 Edite
| Shortcut     | Action                     | Mode |
|--------------|----------------------------|------|
| `S`          | Add surround chars         | v    |
| `cs`         | Change surround chars      | n    |
| `<leader>ts` | Replace all tab with space | n    |
| `<leader>ss` | Quick substitute           | v    |

#### 5 Codeing
| Shortcut     | Action                            | Mode |
|--------------|-----------------------------------|------|
| `<leader>cc` | Comment code                      | n, v |
| `<Tab>`      | Select next item                  | i, s |
| `<S-Tab>`    | Select prev item                  | i, s |
| `<CR>`       | Accept selected item              | i    |
| `<F5>`       | Code runing                       | n    |
| `<F10>`      | Code runing with center float win | n    |

#### 6 File Explorer
| Shortcut     | Action                               | Mode |
|--------------|--------------------------------------|------|
| `<leader>ra` | Edit file                            | n    |
| `<leader>rh` | Split left and edit file             | n    |
| `<leader>rj` | Split bottom and edit file           | n    |
| `<leader>rk` | Split top and edit file              | n    |
| `<leader>rl` | Split right and edit file            | n    |

![yazi](https://s21.ax1x.com/2024/08/05/pkvTBgs.png)

#### 7 Other tools
| Shortcut     | Action                                                             | Mode |
|--------------|--------------------------------------------------------------------|------|
| `:Chdir`     | Jump to the directory where the current buffer                     | n    |
| `<cr>`       | Quickly select the closest text object among a group of candidates | n    |
| `<leader>ww` | Note manager                                                       | n    |
| `<cr>`       | Create or enter note in wiki                                       | n    |

### Dependencies
```shell
bash-language-server
clang
fd
lua
lua-language-server
luarocks
pyright
python
python-black
python-pynvim
ripgrep
shfmt
typescript-language-server
vim-language-server
vscode-css-languageserver
vscode-html-languageserver
vscode-json-languageserver
yazi
```

## Thanks
- [glepnir](https://github.com/glepnir/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)

---

### License MIT
