--- Configure TOML Language Support
--- Used with:
--- * Python project configuration (`pyproject.toml`)

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "toml",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "taplo",
      })
    end,
  },
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        taplo = { evenBetterToml = { schema = { catalogs = { "https://www.schemastore.org/api/json/catalog.json" } } } },
      },
    },
  },
}
