return {
  "folke/snacks.nvim",

  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = true,
      preset = {
        header = [[
      _______  ________  ________  ________   ________  ________ 
    ╱╱   ╱   ╲╱        ╲╱        ╲╱    ╱   ╲ ╱        ╲╱        ╲
   ╱╱        ╱         ╱         ╱         ╱_╱       ╱╱         ╱
  ╱         ╱        _╱         ╱╲        ╱╱         ╱         ╱ 
  ╲__╱_____╱╲________╱╲________╱  ╲______╱ ╲________╱╲__╱__╱__╱  
  ]],
      },
    },
  },
}
