--- Configure Lua Language Support
--- Used with:
--- * Neovim configuration

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua",
        "luap",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "lua-language-server",
        "stylua",
        "selene",
      })
    end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
      },
    },
  },
  { -- Linters to use
    "nvim-lint",
    opts = {
      linters_by_ft = {
        lua = { "selene" },
      },
    },
  },
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        lua_ls = { settings = { Lua = { hint = { enable = true, arrayIndex = "Disable" } } } },
      },
    },
  },
}
