return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { { "nvim-lua/plenary.nvim" } },

    config = function()
        local harpoon = require("harpoon")

        harpoon:setup()
        local keymap = vim.keymap

        keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end, { desc = "Add file to harpoon list" })

        keymap.set("n", "<leader>bx", function()
            harpoon:list():remove()
        end, { desc = "Remove file in current buffer from harpoon list " })

        keymap.set("n", "<leader>1", function()
            harpoon:list():select(1)
        end, { desc = "Go to Harpoon File 1" })

        keymap.set("n", "<leader>2", function()
            harpoon:list():select(2)
        end, { desc = "Go to Harpoon File 2" })

        keymap.set("n", "<leader>3", function()
            harpoon:list():select(3)
        end, { desc = "Go to Harpoon File 3" })

        keymap.set("n", "<leader>4", function()
            harpoon:list():select(4)
        end, { desc = "Go to Harpoon File 4" })

        -- Toggle previous & next buffers stored within Harpoon File list
        keymap.set("n", "<leader>bp", function()
            harpoon:list():prev()
        end, { desc = "Toggle next buffer in Harpoon File list" })

        keymap.set("n", "<leader>bn", function()
            harpoon:list():next()
        end, { desc = "Toggle previous buffer in Harpoon File list" })
    end,
}
