
-- Insert markdown table of contents
function GenerateMarkdownTOC()
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local toc = {}
	for _, line in ipairs(lines) do
		local level, title = string.match(line, "^(##+)%s*(.*)")
		if level and title then
			local item =
				string.format("%s* [%s](#%s)", string.rep("  ", #level - 2), title, title:lower():gsub("%s+", "-"))
			table.insert(toc, item)
		end
	end
	return toc
end

function InsertMarkdownTOC()
	local toc = GenerateMarkdownTOC()
	local row, _ = unpack(vim.api.nvim_win_get_cursor(0))
	vim.api.nvim_buf_set_lines(0, row, row, false, toc)
end

vim.api.nvim_set_keymap("n", "<leader>mt", ":lua InsertMarkdownTOC()<CR>", {noremap = true, silent = true})

-- replace word with clipboard
function ReplaceWithClipboard()
  local clipboard_content= vim.fn.getreg('"')
  vim.fn.expand('<cword>')
  vim.api.nvim_command('normal! ciw' .. clipboard_content)
  vim.fn.setreg('"', clipboard_content)
end

vim.api.nvim_set_keymap("n", "dp", ":lua ReplaceWithClipboard()<CR>", {noremap = true, silent = true})

