--- Configure Rego Language Support
--- Used with:
--- * OPA policies

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "rego",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "regols",
      })
    end,
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
