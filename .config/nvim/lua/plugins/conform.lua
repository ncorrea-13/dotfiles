return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      sql = { "sqlfluff" },
      plsql = { "sqlfluff" },
    },
    formatters = {
      sqlfluff = {
        args = { "format", "--dialect=oracle", "-" },
      },
    },
  },
}
