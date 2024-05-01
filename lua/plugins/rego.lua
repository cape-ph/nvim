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
  { -- HACK: needed until regols is added upstream for auto-detection
    -- https://github.com/williamboman/mason-lspconfig.nvim/pull/403
    "astrolsp",
    ---@param opts AstroLSPOpts
    opts = function(_, opts)
      if not opts.servers then opts.servers = {} end
      table.insert(opts.servers, "regols")
    end,
  },
}
