--- Configure Python Language Support
--- Used with:
--- * Hosted web applications on CAPE

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "html",
        "css",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      if vim.fn.executable "npm" == 1 then
        vim.list_extend(opts.ensure_installed, {
          "html-lsp",
          "css-lsp",
          "tailwindcss-language-server",
        })
      end
    end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettier" },
        vue = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        less = { "prettier" },
      },
    },
  },
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
      },
    },
  },
}
