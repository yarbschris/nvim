return {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            svelte = { "eslint_d" },
            python = { "pylint" },
            c = { "cpplint" },
            cmake = { "cmakelint" },
            cpp = { "cpplint" },
        }
        -- Use the Mason binary explicitly and run cpplint from the file's directory
        local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

        lint.linters.cpplint = vim.tbl_extend("force", lint.linters.cpplint or {}, {
            cmd = mason_bin .. "/cpplint", -- avoid PATH ambiguity
            stdin = false, -- cpplint wants a real file path
            args = { "$FILENAME" }, -- keep flags minimal; add your filters if you want
            cwd = function() -- run in the file's folder to avoid ENOENT on cwd
                return vim.fn.expand("%:p:h")
            end,
        })

        local function should_lint()
            -- skip special/temporary buffers (Telescope, help, quickfix, prompts, etc.)
            if vim.bo.buftype ~= "" then
                return false
            end
            -- skip unnamed or unsaved buffers
            local file = vim.api.nvim_buf_get_name(0)
            if file == "" or vim.fn.filereadable(file) == 0 then
                return false
            end
            -- only lint if there is a linter configured for this filetype
            local ft = vim.bo.filetype
            return ft ~= "" and lint.linters_by_ft[ft] ~= nil
        end

        local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

        vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                if should_lint() then
                    vim.schedule(function()
                        lint.try_lint()
                    end)
                end
            end,
        })

        vim.keymap.set("n", "<leader>l", function()
            lint.try_lint()
        end, { desc = "Trigger linting for current file" })
    end,
}
