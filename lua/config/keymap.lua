local M = {}
vim.g.mapleader = " "

vim.keymap.set("i", "jj", "<Esc>", { noremap = true })
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear text search with <Esc>" })

function M.gitsigns_keymaps(gitsigns)
	vim.keymap.set("n", "<leader>vs", gitsigns.stage_hunk, { desc = "Stage Hunk" })
	vim.keymap.set("n", "<leader>vu", gitsigns.undo_stage_hunk, { desc = "Undo Stage Hunk" })
	vim.keymap.set("n", "<leader>vr", gitsigns.reset_hunk, { desc = "Reset Hunk" })
	vim.keymap.set("n", "<leader>vp", gitsigns.preview_hunk, { desc = "Preview Hunk" })
	vim.keymap.set("n", "<leader>vb", gitsigns.blame_line, { desc = "Blame Line" })
	vim.keymap.set("n", "<leader>vf", gitsigns.diffthis, { desc = "Diff This" })
	vim.keymap.set("n", "<leader>vn", gitsigns.next_hunk, { desc = "Next Hunk" })
end

function M.telescope_keymaps(telescope)
	vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, {})
	vim.keymap.set("n", "<leader>pf", telescope.find_files, {})
	vim.keymap.set("n", "<leader>fr", telescope.lsp_document_symbols, { noremap = true, silent = true })
	vim.keymap.set("n", "<leader>pb", telescope.buffers, {})
	vim.keymap.set("n", "<leader>ph", telescope.help_tags, {})
	vim.keymap.set("n", "<leader>ps", function()
		telescope.grep_string({ search = vim.fn.input("Grep > ") })
	end)
end

function M.conform_keymaps(conform)
	vim.keymap.set({ "n", "v" }, "<leader>ff", function()
		conform.format({
			lsp_fallback = true,
			async = false,
			timeout_ms = 500,
		})
	end, { desc = "", nowait = true })
end

function M.neotree(_)
	vim.keymap.set("n", "<leader>bb", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neotree File Browser" })
	vim.keymap.set(
		"n",
		"<leader>bg",
		"<cmd>Neotree source=git_status toggle<cr>",
		{ desc = "Toggle Neotree Git Status" }
	)
	vim.keymap.set("n", "<leader>bf", "<cmd>Neotree source=buffers toggle<cr>", { desc = "Toggle Buffers" })
end

function M.linting(lint)
	vim.keymap.set("n", "<leader>l", function()
		lint.try_lint()
	end, { desc = "Trigger linting for current file" })
	vim.keymap.set("n", "<leader>dl", "<cmd>lua vim.diagnostic.open_float()<cr>", {})
	vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", {})
	vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", {})
end

function M.cmp(cmp)
	vim.keymap.set("i", "<C-n>", cmp.mapping.complete, { desc = "Open completion", nowait = true })
end

function M.lsp(opts)
	vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
	vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
	vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
	vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
	vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
	vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
	vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
	vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
	vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
end

return M
