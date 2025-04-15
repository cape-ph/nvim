--- Configure JSON Language Support
--- Used with:
--- * OPA policies

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "json",
        "jsonc",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        { "json-lsp", condition = function() return vim.fn.executable "npm" == 1 end },
      },
    },
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        json = { "prettier" },
        jsonc = { "prettier" },
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
        jsonls = {
          on_new_config = function(config)
            if not config.settings.json.schemas then config.settings.json.schemas = {} end
            vim.list_extend(config.settings.json.schemas, require("schemastore").json.schemas())
          end,
          settings = { json = { validate = { enable = true } } },
        },
      },
    },
  },
}
