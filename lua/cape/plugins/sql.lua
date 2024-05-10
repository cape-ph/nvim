--- Configure SQL Language Support
--- Used with:
--- * AWS Athena queries

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "sql" }) end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts) vim.list_extend(opts.ensure_installed, { "sqlfluff" }) end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
  { -- Linters to use
    "nvim-lint",
    opts = {
      linters_by_ft = {
        sql = { "sqlfluff" },
      },
    },
  },
}
