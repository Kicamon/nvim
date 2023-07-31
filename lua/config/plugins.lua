local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	require("plugins.acm"),
	require("plugins.code"),
	require("plugins.colorscheme"),
	require("plugins.editor"),
	require("plugins.gitsigns"),
	require("plugins.lspconfig"),
	require("plugins.markdown"),
	require("plugins.telescope"),
	require("plugins.treesitter"),
	require("plugins.ui"),
})
