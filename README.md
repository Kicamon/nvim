<h1 align="center">
  Neovim Config“
</h1>


![demo](./demo.png)

### Keyboard Shortcuts

leader = `<space>`

#### 1 Base
| Shortcut           | Action                                 | Mode |
|--------------------|----------------------------------------|------|
| `W`                | save file                              | n    |
| `Q`                | quit file                              | n    |
| `B`                | delete current buffer                  | n    |
| `N`                | :nomal                                 | v    |
| `Y`                | Copy selected text to system clipboard | v    |
| `ca`               | Copy full text to system clipboard     | n    |
| `<leader>` `sc`    | toggle spell check                     | n    |
| `<leader>` `sw`    | toggle wrap                            | n    |
| `<leader>` `<cr>`  | nohlsearch                             | n    |
| `Ctrl` `n`         | Escape from terminal input mode        | t    |
| `<leader><leader>` | Goto the next placeholder (<++>)       | n    |

#### 2 Move
| Shortcut  | Action                            | Mode |
|-----------|-----------------------------------|------|
| `j`       | gj                                | n    |
| `k`       | gk                                | n    |
| `H`       | Cursor to the start of the line   | n    |
| `J`       | Cursor down 10 terminal lines     | n    |
| `K`       | Cursor up 10 terminal lines       | n    |
| `L`       | Cursor to the end of the line     | n    |
| `Alt` `l` | Cursor right                      | i    |
| `Alt` `j` | Move selected / current line down | v, n |
| `Alt` `k` | Move selected / current line down | v, n |

#### 3 Windows Splits
| Shortcut       | Action                                                                      | Mode |
|----------------|-----------------------------------------------------------------------------|------|
| `s` `h`        | Create a new vertical split screen and place it left to the current window  | n    |
| `s` `j`        | Create a new vertical split screen and place it below to the current window | n    |
| `s` `k`        | Create a new vertical split screen and place it above to the current window | n    |
| `s` `l`        | Create a new vertical split screen and place it right to the current window | n    |
| `s` `m` `v`    | Rotate splits and arrange splits vertically                                 | n    |
| `s` `m` `h`    | Rotate splits and arrange splits horizontally                               | n    |
| `<leader>` `h` | Move cursor one window left                                                 | n    |
| `<leader>` `j` | Move cursor one window down                                                 | n    |
| `<leader>` `k` | Move cursor one window up                                                   | n    |
| `<leader>` `l` | Move cursor one window right                                                | n    |
| `<up>`         | Add current window height                                                   | n    |
| `<down>`       | Sub current window height                                                   | n    |
| `<left>`       | Sub current window width                                                    | n    |
| `<right>`      | Add current window width                                                    | n    |

#### 4 buffers and tabs
| Shortcut | Action               | Mode |
|----------|----------------------|------|
| `[` `b`  | Goto previous buffer | n    |
| `]` `b`  | Goto next buffer     | n    |
| `t` `u`  | New tab              | n    |
| `t` `n`  | Goto next tab        | n    |
| `t` `p`  | Goto previous tab    | n    |
| `g` `f`  | Goto file new tab    | n    |
| `t` `t`  | Open file browser    | n    |


### Install
```shell
bash-language-server
clang
vscode-json-languageserver
lua-language-server
pyright
vim-language-server
python-black
yarn
```


---

### License MIT
