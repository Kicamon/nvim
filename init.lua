-- ============================================
-- ███╗   ███╗██╗   ██╗██╗   ██╗██╗███╗   ███╗
-- ████╗ ████║╚██╗ ██╔╝██║   ██║██║████╗ ████║
-- ██╔████╔██║ ╚████╔╝ ██║   ██║██║██╔████╔██║
-- ██║╚██╔╝██║  ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚═╝ ██║   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝     ╚═╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
-- ============================================

-- ====================================
-- ===  Basic setting for vim use   ===
-- ====================================
-- 显示行号和相对行号
vim.o.number = true
vim.o.relativenumber = true
-- tab 缩进
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.termguicolors = true
-- 高亮本行
vim.o.cursorline = true
-- 复制粘贴
vim.keymap.set("v", "<C-Insert>", '"+y', {noremap = true, silent = true})
vim.keymap.set("n", "<S-Insert>", '"*p', {noremap = true, silent = true})
-- 离底行数
vim.o.scrolloff = 4
-- leaderkey
vim.g.mapleader = " "
-- 可视行跳转
vim.keymap.set("n", "j", [[v:count ? 'j' : 'gj']], {noremap = true, expr = true})
vim.keymap.set("n", "k", [[v:count ? 'k' : 'gk']], {noremap = true, expr = true})

-- ====================================
-- === Plug config ====================
-- ====================================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system(
        {
            "git",
            "clone",
            "--filter=blob:none",
            "https://github.com/folke/lazy.nvim.git",
            "--branch=stable", -- latest stable release
            lazypath
        }
    )
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({{import = "plugins"}})
