return {
    dir = ".",
    name = "ac-adapter-rs",
    config = function()
        local workspace = vim.fs.normalize("~/repos/ac-adapter-rs")

        local function expand_ac_adapter(libname)
            local cmd = { "procon-bundler", "find", workspace, libname }
            local result_tbl = vim.system(cmd, { text = true }):wait()
            local result = result_tbl.stdout or ""
            local err = result_tbl.stderr or ""

            if result_tbl.code ~= 0 then
                vim.notify(err ~= "" and err or result, vim.log.levels.ERROR)
                return
            end

            local lines = {}
            for line in result:gmatch("[^\r\n]+") do
                table.insert(lines, line)
            end

            vim.api.nvim_buf_set_lines(0, -1, -1, false, lines)
        end

        vim.api.nvim_create_user_command("Snip", function(opts)
            expand_ac_adapter(opts.args)
        end, { nargs = 1 })
    end,
}
