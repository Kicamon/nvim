return {
	"xeluxee/competitest.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	ft = {"cpp"},
	
	config = function()
		require('competitest').setup()
		vim.keymap.set("n", "rr", ":CompetiTestRun<CR>", { noremap = true })
		vim.keymap.set("n", "ra", ":CompetiTestAdd<CR>", { noremap = true })
		vim.keymap.set("n", "re", ":CompetiTestEdit<CR>", { noremap = true })
		vim.keymap.set("n", "ri", ":CompetiTestReceive testcases<CR>", { noremap = true })
		vim.keymap.set("n", "rd", ":CompetiTestDelete<CR>", { noremap = true })
		--vim.keymap.set("n", "acm", ":CompetiTestReceive contest<CR>", { noremap = true, silent = true })
	end
}
