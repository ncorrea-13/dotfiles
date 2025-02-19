-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local live_rename = require("live-rename")

-- the following are equivalent
vim.keymap.set("n", "<leader>r", live_rename.rename, { desc = "LSP rename" })
vim.keymap.set("n", "<leader>r", live_rename.map(), { desc = "LSP rename" })
vim.keymap.set("n", "<leader>r", live_rename.map({}), { desc = "LSP rename" })

-- the following are equivalent
vim.keymap.set("n", "<leader>R", live_rename.map({ text = "", insert = true }), { desc = "LSP rename" })
vim.keymap.set("n", "<leader>R", function()
  live_rename.rename({ text = "", insert = true })
end, { desc = "LSP rename" })

--Undotree config
vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Undotree" })
