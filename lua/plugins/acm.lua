return {
	"xeluxee/competitest.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	ft = { "cpp" },
	config = function()
		require('competitest').setup()
		vim.keymap.set("n", "rr", ":CompetiTest run<CR>", { noremap = true })
		vim.keymap.set("n", "ra", ":CompetiTest add_testcase<CR>", { noremap = true })
		vim.keymap.set("n", "re", ":CompetiTest edit_testcase<CR>", { noremap = true })
		vim.keymap.set("n", "ri", ":CompetiTest receive testcases<CR>", { noremap = true })
		vim.keymap.set("n", "rd", ":CompetiTest delete_testcase<CR>", { noremap = true })
		vim.keymap.set("n", "acm", ":CompetiTest receive contest<CR>", { noremap = true })
	end
}
