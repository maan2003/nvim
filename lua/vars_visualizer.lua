local M = {}
local Job = require'plenary.job'

M.command_env = {
    graph = function (data, opts) 
        opts = opts or {}
        opts.data = data
        return {
            opts = opts,
            get_input = function()
                local json = vim.json.encode(opts) .. '\n'
                return json
            end
        }
    end
}
local programs = {
    graph = "vis_graph",
}

function M.new(cmd)
    local idx = cmd:find('%(')
    -- local progn = programs[cmd:sub(1, idx - 1)]
    local var, progn = cmd:match("^(%a-) = (%a+)")
    if var then
        cmd = cmd .. '; return ' .. var
    else
        progn = cmd:match('^(%a+)%(')
        if progn then
            cmd = 'return ' .. cmd
        end
    end
    progn = programs[progn]
    local chunk = loadstring(cmd)
    local job
    if progn then
        job = Job:new({
            command = progn,
        })
        _G.mx_job = job
        job:start()
    end
    return {
        get = function (env) 
            setfenv(chunk, env)
            local obj = chunk()
            return function () 
                if obj and job then
                    local input = obj.get_input()
                    vim.pretty_print(input)
                    job:send(input)
                end
            end
        end
    }
end

return M
