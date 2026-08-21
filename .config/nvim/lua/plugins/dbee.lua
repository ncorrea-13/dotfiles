return {
  "kndndrj/nvim-dbee",
  dependencies = { "MunifTanjim/nui.nvim" },
  build = function()
    require("dbee").install()
  end,
  config = function()
    local ok, connections = pcall(require, "env.dbee_connections")
    if not ok then
      connections = {}
    end
    require("dbee").setup({
      sources = {
        require("dbee.sources").MemorySource:new(connections),
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "dbee",
      callback = function(event)
        local wk = require("which-key")
        wk.add({
          { "<CR>", desc = "Select/Connect", buffer = event.buf },
          { "o", desc = "Toggle expand/collapse", buffer = event.buf },
          { "cw", desc = "Rename", buffer = event.buf },
          { "dd", desc = "Delete", buffer = event.buf },
          { "r", desc = "Refresh", buffer = event.buf },
          { "y", desc = "Yank", buffer = event.buf },
        })
      end,
    })
  end,
  keys = {
    { "<leader>d", group = "dbee" },
    {
      "<leader>db",
      function()
        require("dbee").toggle()
      end,
      desc = "Toggle DBee",
    },
  },
}
