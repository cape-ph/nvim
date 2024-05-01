--- Configure YAML Language Support
--- Used with:
--- * GitHub Actions

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "yaml",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "yaml-language-server",
        "prettier",
      })
    end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        yaml = { "prettier" },
      },
    },
  },
  { "b0o/SchemaStore.nvim", lazy = true },
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        yamlls = {
          on_new_config = function(config)
            config.settings.yaml.schemas =
              vim.tbl_deep_extend("force", config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
          end,
          settings = { yaml = { schemaStore = { enable = false, url = "" } } },
        },
      },
    },
  },
}
