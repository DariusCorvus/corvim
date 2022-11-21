local status_ok, notify = pcall(require, "notify")

local function wrap_message(message, size)
	local lines = {}

	for i = 1, #message, size do
		local line = message:sub(i, i + size - 1)
		line = line:gsub("\n", "")
		line = line:match("^%s*(.*)")
		lines[#lines + 1] = line
	end

	return lines
end

local function notify_wrap_message(message, level, opts)
	notify(wrap_message(message, 60), level, opts)
end

if status_ok then
	notify.setup({
		top_down = false,
		max_width = 60,
		timeout = 3000,
		fps = 60,
	})

	vim.notify = notify_wrap_message
end
