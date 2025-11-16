<h1 align="center">
  Personal Neovim Config“
</h1>

![demo](https://private-user-images.githubusercontent.com/96783720/505765842-2a7ecfb9-46e5-40f9-ab1b-7cb7510d3f44.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjMyMTcxMjQsIm5iZiI6MTc2MzIxNjgyNCwicGF0aCI6Ii85Njc4MzcyMC81MDU3NjU4NDItMmE3ZWNmYjktNDZlNS00MGY5LWFiMWItN2NiNzUxMGQzZjQ0LnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTExMTUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUxMTE1VDE0MjcwNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWQwZmZhNTliYTk5ODNhNzkzMWJhZmUxYzcyNzlkZDE4MDM5ZGRkYjg0OWU4YWZmMjUyOTYxNDRjNjRhMmVjNmImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.hNkC4iuNNV8tRkKQB5_O2j5VjLsc2H54Uv44fPzjWWQ)

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
| `s`      | flash jump                      | n，v |

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

![code running](https://private-user-images.githubusercontent.com/96783720/505765979-0a1806fa-9f4b-43eb-a93f-ea8067947efb.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjMyMTcxMjQsIm5iZiI6MTc2MzIxNjgyNCwicGF0aCI6Ii85Njc4MzcyMC81MDU3NjU5NzktMGExODA2ZmEtOWY0Yi00M2ViLWE5M2YtZWE4MDY3OTQ3ZWZiLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTExMTUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUxMTE1VDE0MjcwNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWJhODFlN2U0MmNlY2M5MjI3M2YzZjY1Y2M4MTA4NTlmMDA1MGJiYzc3NWVlYTQ2NjZlYTQyNDFjNjFhN2QxODImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.FBiHrP1qUZQRVksdxpAvdiBWFKO_lj3wNQR769hl2AI)

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

![yazi](https://private-user-images.githubusercontent.com/96783720/505765843-8976e340-62f4-4708-92b5-327d3d2ebfd0.png?jwt=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTUiLCJleHAiOjE3NjMyMTcxMjQsIm5iZiI6MTc2MzIxNjgyNCwicGF0aCI6Ii85Njc4MzcyMC81MDU3NjU4NDMtODk3NmUzNDAtNjJmNC00NzA4LTkyYjUtMzI3ZDNkMmViZmQwLnBuZz9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFWQ09EWUxTQTUzUFFLNFpBJTJGMjAyNTExMTUlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjUxMTE1VDE0MjcwNFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPTNkN2UwZmNkODQ2YTliOTU3ODg0ZmM5MDE4NjlkM2UzYTIxZWMxN2UwMmEwZjhhNmE4ZTAxMjRlNmZiNTFhMDUmWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0In0.tPFijhZhSSCuGdtqbui5EZV6TzYk4tk6lwwhH1HWq5o)

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
| `<cr>`          | quickly select the closest text object among a group of candidates | n    |
| `<leader>ww`    | note manager                                                       | n    |
| `<cr>`          | create or enter note in wiki                                       | n    |
| `<c-f>`         | toggle float terminal if have not term, create it                  | n, t |
| `<c-r>`         | move float terminal right                                          | t    |
| `<c-c>`         | move float terminal center                                         | t    |

### Plugin list
```shell
nvimdev/lspsaga.nvim
saghen/blink.cmp
nvim-treesitter/nvim-treesitter
ibhagwan/fzf-lua
nvimdev/guard.nvim
folke/flash.nvim
lewis6991/gitsigns.nvim
nvimdev/indentmini.nvim
brenoprata10/nvim-highlight-colors
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
xclip
im-select #if use wsl
```

## Thanks
- [glepnir](https://github.com/glepnir/nvim)
- [theniceboy](https://github.com/theniceboy/nvim/tree/lua-migration)

---

### License MIT
