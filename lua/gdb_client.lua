local uv = vim.loop
local client = nil


vim.cmd [[hi GdbCurrentLineSign guifg=#bbbbbb guibg=#3a3a3a]]
vim.cmd [[hi GdbCurrentLine guibg=#3a3a3a]]
vim.cmd [[hi GdbBreakpointSign guifg=#EA6962]]

local M = {}
local handlers = {}
local function on_message(data)
    data = vim.json.decode(data)
    local func = handlers[data.type]
    if func then
        func(data)
    end
end

local gdb_buf = ""
local function on_read(err, chunk)
    assert(not err, err)
    if not chunk then
        print("MX GDB: disconnected")
        return
    end
    gdb_buf = gdb_buf .. chunk
    while true do
        local idx = gdb_buf:find('\n')
        if idx == nil then
            break
        end
        on_message(gdb_buf:sub(1, idx))
        gdb_buf = gdb_buf:sub(idx + 1)
    end
end

local function on_connect(err)
    assert(not err, err)
    print("MX GDB: connected")
    client:read_start(on_read)
end

M.keymap = {
    d = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local file = vim.api.nvim_buf_get_name(0)
        M.request('break ' .. file .. ':' .. pos[1])
    end,
    D = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local file = vim.api.nvim_buf_get_name(0)
        M.request('clear ' .. file .. ':' .. pos[1])
    end,
    c = function()
        M.request('continue')
    end,
    C = function()
        M.request('reverse-continue')
    end,
    n = function()
        M.request('next')
    end,
    N = function()
        M.request('reverse-next')
    end,
    f = function()
        local pos = vim.api.nvim_win_get_cursor(0)
        local file = vim.api.nvim_buf_get_name(0)
        M.request('until ' .. file .. ':' .. pos[1])
    end
}

function M.connect()
    client = uv.new_tcp()
    client:connect("127.0.0.1", 12220, on_connect)
end

local pending_tokens = {}
local next_token = 1
function M.request(cmd, cb)
    local token = next_token
    next_token = next_token + 1
    if cb ~= nil then
        pending_tokens[token] = cb
    end
    cmd = tostring(token) .. cmd .. '\n'
    client:write(cmd)
end

function handlers.result(data)
    local cb = pending_tokens[data.token]
    if cb then
        pending_tokens[data.token] = nil
        cb(data)
    end
end

local Cursor = require('nvimgdb.cursor')
local config = require('nvimgdb.config').new()
M.cursor = Cursor.new(config)

-- set cursor according to current position
function M.on_frame(frame)
    vim.cmd('e ' .. frame.fullname)
    local line = tonumber(frame.line)
    M.cursor:set(0, line)
    M.cursor:show()
    vim.cmd(tostring(line))
    vim.api.nvim_win_set_cursor(0, { line, 0 })
    for key, func in pairs(M.keymap) do
        vim.keymap.set('n', key, func, { buffer = true })
    end
end

function handlers.notify(data)
    local frame = data.payload.frame
    if frame then
        vim.schedule(function()
            M.on_frame(frame)
        end)
    end
end

return M
