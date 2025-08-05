return {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },

    config = function()
        local mason_dap = require("mason-nvim-dap")
        local dap = require("dap")
        local ui = require("dapui")
        local dap_virtual_text = require("nvim-dap-virtual-text")

        dap.adapters.codelldb = {
            type = "executable",
            command = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb",
        }
        -- Dap Virtual Text
        dap_virtual_text.setup()

        mason_dap.setup({
            ensure_installed = { "codelldb" },
            automatic_installation = true,
            handlers = {
                function(config)
                    require("mason-nvim-dap").default_setup(config)
                end,
            },
        })

        dap.configurations = {
            c = {
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
            },
        }

        -- Dap UI
        ui.setup()
        vim.fn.sign_define("DapBreakpoint", { text = "🐞" })

        dap.listeners.before.attach.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            ui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            ui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            ui.close()
        end

        -- set keymaps
        local keymap = vim.keymap

        keymap.set("n", "<leader>dt", function()
            require("dap").toggle_breakpoint()
        end, { desc = "Toggle Breakpoint" })

        keymap.set("n", "<leader>dc", function()
            require("dap").continue()
        end, { desc = "Continue" })

        keymap.set("n", "<leader>di", function()
            require("dap").step_into()
        end, { desc = "Step Into" })

        keymap.set("n", "<leader>do", function()
            require("dap").step_over()
        end, { desc = "Step Over" })

        keymap.set("n", "<leader>du", function()
            require("dap").step_out()
        end, { desc = "Step Out" })

        keymap.set("n", "<leader>dr", function()
            require("dap").repl.open()
        end, { desc = "Open REPL" })

        keymap.set("n", "<leader>dl", function()
            require("dap").run_last()
        end, { desc = "Run Last" })

        keymap.set("n", "<leader>dq", function()
            require("dap").terminate()
            require("dapui").close()
            require("nvim-dap-virtual-text").toggle()
        end, { desc = "Terminate" })

        keymap.set("n", "<leader>db", function()
            require("dap").list_breakpoints()
        end, { desc = "List Breakpoints" })

        keymap.set("n", "<leader>de", function()
            require("dap").set_exception_breakpoints({ "all" })
        end, { desc = "Set Exception Breakpoints" })
    end,
}
