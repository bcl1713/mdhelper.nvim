if vim.fn.has("nvim-0.7.0") ~= 1 then
	vim.api.nvim_err_writeln("mdhelper.nvim requires at least nvim-0.7.0")
end

local function handle_lists()
	local current_line = vim.api.nvim_get_current_line()
	vim.api.nvim_feedkeys("\n", "n", true)
	if string.find(current_line, "%- %[.]") then
		vim.api.nvim_feedkeys("- [ ] ", "n", true)
	elseif string.find(current_line, "- ", 0, true) then
		vim.api.nvim_feedkeys("- ", "n", true)
	end
end

local enabled = true

vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		local data = {
			buf = vim.fn.expand("<abuf>"),
			file = vim.fn.expand("<aflile>"),
			match = vim.fn.expand("<amatch>"),
		}
		if enabled then
			vim.keymap.set("i", "<cr>", function()
				handle_lists()
			end, { buffer = tonumber(data.buf), noremap = true })
      vim.api.nvim_set_option_value("textwidth", 80, {buf=tonumber(data.buf)})
		end
	end,
})
