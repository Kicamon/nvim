# My neovim profile

## 使用之前
使用的插件管理器：[vim-plug](https://github.com/junegunn/vim-plug)

使用前先根据使用的操作系统进行安装

插件环境要求：
- nodejs >= 14.14.0
- python >= 3.10.0
- npm
- yarn
- clang（使用cpp）

coc.nvim插件使用注意：
进入`./plugged/coc.nvim`文件，运行命令`yarn install`

将 [coc](https://github.com/Kicamon/coc) 插件克隆到.config文件下

## 通用功能
#### PASTE模式的开启与关闭
|     操作     |    快捷键    |
|:------------:|:------------:|
|  :set paste  |    Ctrl+p    |
| :set nopaste | Ctrl+Shift+p |

#### 超出屏幕自动换行
|     操作    |    快捷键    |
|:-----------:|:------------:|
|  :set wrap  |    Ctrl+w    |
| :set nowrap | Ctrl+Shift+w |

#### 复制粘贴
|     操作     |    快捷键    |
|:------------:|:------------:|
| 复制到剪切板 |  Ctrl+Insert |
|     粘贴     | Shift+Insert |

#### 切换Buffers
|  操作  | 快捷键 |
|:------:|:------:|
| 上一个 |   [b   |
| 下一个 |   ]b   |

#### 打开和关闭文件树
| 操作 | 快捷键 |
|:----:|:------:|
| 打开 | \<F12> |
| 关闭 | \<F12> |

#### num-key
> 这个功能是方便进行上下移动的，可以不用伸手去摸数字键就能实现多行上下移动的操作。这里我只配置了40行以内的上下移动，又需要的朋友可以参照写法自行拓展

这里简单的给几个例子就能理解

| 操作 |     命令     |
|:----:|:------------:|
|  8j  |  \<leader>k' |
|  10j | \<leader>a;' |
|  45j | \<leader>f;' |
|  50k | \<leader>g;[ |

非常容易理解，将数字键映射到了中间的一行，这样在上下进行多行移动的时候就不用伸出手指去够上边的数字键了。具体的配置在`num-key`文件夹中

## 编程
> 我的配置只写了cpp，当然，大家可以自行围绕自己所使用的编程语言进行配置

#### 代码补全
在Normal模式下运行下面命令
```Vim Script
:CocInstall coc-clangd
:CocInstall coc-pairs
:CocInstall coc-snippets
```

#### 一键编译等
|       操作       |  快捷键  |
|:----------------:|:--------:|
|     编译运行     |   \<F5>   |
|    自动格式化    |  Ctrl+i  |

我所使用的是Microsoft的码风，如果想要换成Google的码风的话，找到这两行
```Vim Script
let g:formatdef_clangformat_microsoft = '"clang-format -style microsoft -"'
let g:formatters_cpp = ['clangformat_microsoft' ]
```
换成：
```Vim Script
let g:formatdef_clangformat_google = '"clang-format -style google -"'
let g:formatters_cpp = ['clangformat_google']
```

#### 代码模板
代码模板使用的是`coc-snippets` 这个插件，比如我想要存储一个cpp的线段树模板，按照下面步骤操作：
1. 打开一个cpp文件
2. 运行命令：`:CocCommand snippets.editSnippets` 
3. 在文件的末尾加上：

```snippets
snippet SegmentTree "Segment Tree" b
// 线段树的信息
const int N = 2e5 + 10, mod = 1e9 + 7;
int a[N];
struct info // 存储线段树的值
{
    int size;
    int num;
};

struct tag // 存储线段树的懒标记
{
    int add;
    int mul;
};

struct Node // 线段树
{
    info val;
    tag lazy;
} tr[N << 2];
int st_size; // 线段树的总区间大小

// 线段树的具体操作
info operator+(const info &l, const info &r) // pushup的操作
{
    info c;
    c.size = l.size + r.size;
    c.num = (1ll * l.num + r.num) % mod;
    return c;
}

info operator+(const info &v, const tag &t) // pushdown时，对子节点info的操作
{
    info c;
    c.size = v.size;
    c.num = (1ll * v.num * t.mul + 1ll * v.size * t.add) % mod;
    return c;
}

tag operator+(const tag &ts, const tag &tp) // pushdown时，对子节点tag的操作
{
    tag c;
    c.add = (1ll * ts.add * tp.mul + tp.add) % mod;
    c.mul = 1ll * ts.mul * tp.mul % mod;
    return c;
}

void pushup(int u)
{
    tr[u].val = tr[u << 1].val + tr[u << 1 | 1].val;
}

void pushdown(int u)
{
    Node &t = tr[u], &l = tr[u << 1], &r = tr[u << 1 | 1];
    l.val = l.val + t.lazy, l.lazy = l.lazy + t.lazy;
    r.val = r.val + t.lazy, r.lazy = r.lazy + t.lazy;
    t.lazy = {0, 1};
}

void build(int u = 1, int l = 1, int r = st_size)
{
    if (l == r)
    {
        tr[u] = {r - l + 1, a[l], 0, 1};
        return;
    }
    tr[u] = {r - l + 1, 0, 0, 1};
    int mid = l + r >> 1;
    build(u << 1, l, mid), build(u << 1 | 1, mid + 1, r);
    pushup(u);
}

void modify(int u, int l, int r, tag c, int pl = 1, int pr = st_size)
{
    if (l <= pl && pr <= r)
    {
        tr[u].val = tr[u].val + c;
        tr[u].lazy = tr[u].lazy + c;
        return;
    }
    pushdown(u);
    int mid = pl + pr >> 1;
    if (l <= mid)
        modify(u << 1, l, r, c, pl, mid);
    if (r > mid)
        modify(u << 1 | 1, l, r, c, mid + 1, pr);
    pushup(u);
}

int query(int u, int l, int r, int pl = 1, int pr = st_size)
{
    if (l <= pl && pr <= r)
        return tr[u].val.num;
    int mid = pl + pr >> 1;
    pushdown(u);
    int res = 0;
    if (l <= mid)
        res = (1ll * res + query(u << 1, l, r, pl, mid)) % mod;
    if (r > mid)
        res = (1ll * res + query(u << 1 | 1, l, r, mid + 1, pr)) % mod;
    return res;
}
endsnippet
```

之后在写代码的过程中输入`SegmentTree` 就会出现线段树的代码补全


## Markdown
#### 指定浏览器
使用下列命令在配置文件中指定浏览器，不写的话就是调用默认浏览器

我这里使用的是chromium浏览器

```Vim Script
let g:mkdp_browser='chromium'
```



#### 输入法切换
> 当前文件是.md时，进入插入模式时会自动将输入法切换成中文（使用fcitx5）,详细配置查看fctix.vim文件

#### 预览等操作
|    操作    | 快捷键 |
|:----------:|:------:|
|    预览    |  \<F5> |
| 表格格式化 |  Alt+e |
|  插入目录  |  :TOC  |

#### 语法快捷键
具体内容查看本目录下`md-snippets`文件

|   语法  | 快捷键 |
|:-------:|:------:|
|   ****  |   ,b   |
|   ~~~~  |   ,s   |
|    **   |   ,i   |
|    ``   |   ,d   |
|   ```   |   ,c   |
|  - [ ]  |   ,m   |
| \!\[]() |   ,p   |
|  \[]()  |   ,a   |
|    #    |   ,1   |
|    ##   |   ,2   |
|   ###   |   ,3   |
|   ####  |   ,4   |

输入`,f`可以跳出来，自己尝试一下就知道了

------

参考：
1. https://github.com/theniceboy/nvim
2. https://blog.liukairui.me/article/Vim%E9%85%8D%E7%BD%AE%E7%AC%94%E8%AE%B0(%E7%8E%AF%E5%A2%83%E9%85%8D%E7%BD%AE,%E6%8F%92%E4%BB%B6%E6%8E%A8%E8%8D%90,%E7%BE%8E%E5%8C%96)(C++,Python,MarkDown,R...)/
