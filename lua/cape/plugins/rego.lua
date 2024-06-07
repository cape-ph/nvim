--- Configure Rego Language Support
--- Used with:
--- * OPA policies

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "rego",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "regols",
      },
    },
  },
  { -- Linters to use
    "nvim-lint",
    opts = {
      linters_by_ft = {
        rego = { "opa_check" },
      },
    },
  },
}
