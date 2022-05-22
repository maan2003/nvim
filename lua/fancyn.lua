local current_mode = "search"
local modes = {
    search = "search",
    quickfixlist = "quickfixlist",
    locationlist = "locationlist",
}

function search() 
    set_mode("search")
    vim.api.nvim_feedkeys("/", "n", false)
end

function set_mode(mode)
    current_mode = mode
end

function print_error(err)
    vim.cmd(string.format([[echohl ErrorMsg | echom '%s' | echohl None]], err))
end

function fancy_n()
    local cmd
    if current_mode == modes.search then
        cmd = "normal! n"
    elseif current_mode == modes.quickfixlist then
        cmd = "cnext"
    elseif current_mode == modes.locationlist then
        cmd = "lnext"
    end
    xpcall(vim.cmd, function(err)
        print_error(string.gsub(err, [[^Vim%(.*%):]], ""))
    end, cmd)
end

function fancy_N()
    local cmd
    if current_mode == "search" then
        cmd = "normal! N"
    elseif current_mode == "quicklist" then
        cmd = "cprevious"
    elseif current_mode == "locallist" then
        cmd = "lprevious"
    end
    xpcall(vim.cmd, function(err)
        p = "Vim(normal):"
        local err = (err:sub(0, #p) == p) and err:sub(#p+1) or err
        print_error(err)
    end, cmd)
end

return { search = search, set_mode = set_mode, modes = modes, n = fancy_n, N = fancy_N }
