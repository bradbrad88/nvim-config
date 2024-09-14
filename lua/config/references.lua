-- Util functions
local function every(arr, cb)
	for _, item in ipairs(arr) do
		local test = cb(item)
		if not test then
			return false
		end
	end
	return true
end

local function concat(arr, ...)
	local args = { ... }
	for i = 1, #args do
		local current_table = args[i]
		for _, v in ipairs(current_table) do
			table.insert(arr, v)
		end
	end
end

local function filter(arr, cb)
	local filtered_arr = {}
	for _, item in ipairs(arr) do
		local res = cb(item)
		if res then
			table.insert(filtered_arr, item)
		end
	end
	return filtered_arr
end

local function filter_uri(uri)
	local fn = function(reference)
		return not string.match(uri, reference.uri)
	end
	return fn
end

local function filter_duplicates(locmap)
	local fn = function(reference)
		local key = reference.uri .. ":" .. reference.range.start.line
		if locmap[key] then
			return false
		else
			locmap[key] = true
			return true
		end
	end
	return fn
end

-- Handlers
local function handle_document_symbols(_, cb)
	vim.lsp.buf.document_symbol({
		on_list = function(symbols)
			for _, symbol in ipairs(symbols.items) do
				local line = symbol.lnum
				local character = symbol.col
				local position = { line = line, character = character }
				cb(position)
			end
		end,
	})
end

local function filter_definitions(params, cb, err_cb)
	return function(position)
		local skip_def_check = false
		local definition_belongs_to_current_buffer = true

		vim.lsp.buf_request(params.bufnr, "textDocument/definition", {
			textDocument = { uri = params.uri },
			position = position,
		}, function(err, definitions)
			if err then
				print(vim.inspect(err))
				return err_cb(err)
			end
			if not definitions then
				return err_cb()
			end
			if not skip_def_check then
				definition_belongs_to_current_buffer = every(definitions, function(definition)
					return string.match(definition.targetUri, params.uri)
				end)
			end
			if not definition_belongs_to_current_buffer then
				return err_cb()
			end
			cb(position)
		end)
	end
end

local function handle_references(params, cb, err_cb)
	return function(position)
		vim.lsp.buf_request(params.bufnr, "textDocument/references", {
			textDocument = { uri = params.uri },
			position = position,
			context = {
				includeDeclaration = true,
			},
		}, function(err, references)
			if err then
				print(vim.inspect(err))
				return err_cb(err)
			end
			if references then
				local references_filtered_by_uri = filter(references, filter_uri(params.uri))
				cb(references_filtered_by_uri)
			else
				err_cb()
			end
		end)
	end
end

local function handle_duplicates(locmap, cb)
	return function(references)
		local unique_references = filter(references, function(reference)
			return filter_duplicates(locmap)(reference)
		end)
		cb(unique_references)
	end
end

local function collate_references(references, cb)
	return function(new_references)
		local collated_references = concat(references, new_references)
		cb(collated_references)
	end
end

local function manage_callbacks(cb)
	local count = 0
	local M = {
		count = count,
	}
	function M.new_callback()
		M.count = M.count + 1
	end
	function M.callback_complete()
		M.count = M.count - 1
		if M.count == 0 then
			cb()
		end
	end
	return M
end

local function coordinate(params)
	local references = {}
	local function on_complete()
		local items = vim.lsp.util.locations_to_items(references, "utf-8")
		vim.fn.setqflist({}, " ", { title = "Something", items = items })
		vim.cmd("copen")
		vim.cmd("wincmd J")
	end
	local manager = manage_callbacks(on_complete)
	local locmap = {}

	local filter_duplicate_handler =
		handle_duplicates(locmap, collate_references(references, manager.callback_complete))
	local reference_handler = handle_references(params, filter_duplicate_handler, manager.callback_complete)
	local filter_definition_handler = filter_definitions(params, reference_handler, manager.callback_complete)
	local handle_definitions = function(position)
		manager.new_callback()
		filter_definition_handler(position)
	end
	handle_document_symbols(params, handle_definitions)
end

local function get_all_references_for_document()
	local bufnr = vim.api.nvim_get_current_buf()
	local window_id = vim.api.nvim_get_current_win()
	local uri = vim.uri_from_bufnr(bufnr)
	local params = { bufnr = bufnr, window_id = window_id, uri = uri }
	coordinate(params)
end

vim.keymap.set("n", "<leader>ra", get_all_references_for_document, { noremap = true, silent = true })
