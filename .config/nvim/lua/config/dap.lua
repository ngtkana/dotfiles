-- nvim-dap 設定

local M = {}

function M.setup()
    local has_dap, dap = pcall(require, "dap")
    local has_dapui, dapui = pcall(require, "dapui")
    local has_dap_vt, dap_vt = pcall(require, "nvim-dap-virtual-text")

    if not has_dap then
        return
    end

    -- DAP UI 設定
    if has_dapui then
        dapui.setup({
            icons = { expanded = "▾", collapsed = "▸" },
            mappings = {
                -- DAP UI 内のキーマッピング
                expand = { "<CR>", "<2-LeftMouse>" },
                open = "o",
                remove = "d",
                edit = "e",
                repl = "r",
                toggle = "t",
            },
            layouts = {
                {
                    elements = {
                        -- 左側のパネル要素
                        { id = "scopes", size = 0.25 },
                        { id = "breakpoints", size = 0.25 },
                        { id = "stacks", size = 0.25 },
                        { id = "watches", size = 0.25 },
                    },
                    size = 40,
                    position = "left",
                },
                {
                    elements = {
                        -- 下部のパネル要素
                        { id = "repl", size = 0.5 },
                        { id = "console", size = 0.5 },
                    },
                    size = 10,
                    position = "bottom",
                },
            },
            floating = {
                max_height = nil,
                max_width = nil,
                border = "rounded",
                mappings = {
                    close = { "q", "<Esc>" },
                },
            },
            windows = { indent = 1 },
            render = {
                max_type_length = nil,
            },
        })

        -- DAP イベントリスナー
        dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
        end
        dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
        end
    end

    -- 仮想テキスト設定
    if has_dap_vt then
        dap_vt.setup({
            enabled = true,
            enabled_commands = true,
            highlight_changed_variables = true,
            highlight_new_as_changed = false,
            show_stop_reason = true,
            commented = false,
            virt_text_pos = "eol",
            all_frames = false,
            virt_lines = false,
            virt_text_win_col = nil,
        })
    end

    -- アイコン設定
    vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapBreakpointCondition",
        { text = "🟡", texthl = "DapBreakpointCondition", linehl = "", numhl = "" }
    )
    vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DapLogPoint", linehl = "", numhl = "" })
    vim.fn.sign_define(
        "DapStopped",
        { text = "▶️", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" }
    )
    vim.fn.sign_define(
        "DapBreakpointRejected",
        { text = "⭕", texthl = "DapBreakpointRejected", linehl = "", numhl = "" }
    )

    -- 言語ごとのデバッガ設定
    -- JavaScript/TypeScript (Node.js)
    dap.adapters.node2 = {
        type = "executable",
        command = "node",
        args = { vim.fn.stdpath("data") .. "/mason/packages/node-debug2-adapter/out/src/nodeDebug.js" },
    }

    dap.configurations.javascript = {
        {
            name = "Launch",
            type = "node2",
            request = "launch",
            program = "${file}",
            cwd = "${workspaceFolder}",
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
        },
        {
            name = "Attach to process",
            type = "node2",
            request = "attach",
            processId = require("dap.utils").pick_process,
        },
    }

    dap.configurations.typescript = dap.configurations.javascript

    -- Python
    dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/packages/debugpy/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
    }

    dap.configurations.python = {
        {
            type = "python",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            pythonPath = function()
                -- 仮想環境の検出
                local venv_path = os.getenv("VIRTUAL_ENV")
                if venv_path then
                    return venv_path .. "/bin/python"
                end
                -- pyenv の検出
                local handle = io.popen("which python")
                if handle then
                    local result = handle:read("*a")
                    handle:close()
                    return result:gsub("\n", "")
                end
                return "python"
            end,
        },
    }

    -- Rust (via codelldb)
    dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
            command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
            args = { "--port", "${port}" },
        },
    }

    dap.configurations.rust = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                -- カーゴプロジェクトのターゲットを検出
                local handle = io.popen("cargo metadata --format-version 1 | jq -r '.packages[0].targets[0].name'")
                if handle then
                    local target = handle:read("*a"):gsub("\n", "")
                    handle:close()
                    return "${workspaceFolder}/target/debug/" .. target
                end
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
            args = function()
                local args_str = vim.fn.input("Arguments: ")
                local args = {}
                for arg in args_str:gmatch("%S+") do
                    table.insert(args, arg)
                end
                return args
            end,
        },
    }

    -- C/C++
    dap.configurations.cpp = {
        {
            name = "Launch file",
            type = "codelldb",
            request = "launch",
            program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
        },
    }

    dap.configurations.c = dap.configurations.cpp

    -- Go
    dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
            command = "dlv",
            args = { "dap", "-l", "127.0.0.1:${port}" },
        },
    }

    dap.configurations.go = {
        {
            type = "delve",
            name = "Debug",
            request = "launch",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test",
            request = "launch",
            mode = "test",
            program = "${file}",
        },
        {
            type = "delve",
            name = "Debug test (go.mod)",
            request = "launch",
            mode = "test",
            program = "./${relativeFileDirname}",
        },
    }

    -- キーマッピング
    vim.keymap.set("n", "<F5>", function()
        require("dap").continue()
    end, { desc = "Debug: Continue" })
    vim.keymap.set("n", "<F10>", function()
        require("dap").step_over()
    end, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F11>", function()
        require("dap").step_into()
    end, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", function()
        require("dap").step_out()
    end, { desc = "Debug: Step Out" })
    vim.keymap.set("n", "<leader>db", function()
        require("dap").toggle_breakpoint()
    end, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>dB", function()
        require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Conditional Breakpoint" })
    vim.keymap.set("n", "<leader>dl", function()
        require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
    end, { desc = "Debug: Set Log Point" })
    vim.keymap.set("n", "<leader>dr", function()
        require("dap").repl.open()
    end, { desc = "Debug: Open REPL" })
    vim.keymap.set("n", "<leader>du", function()
        require("dapui").toggle()
    end, { desc = "Debug: Toggle UI" })
end

return M
