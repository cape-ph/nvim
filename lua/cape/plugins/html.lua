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
    opts = {
      ensure_installed = {
        { "html-lsp", condition = function() return vim.fn.executable "npm" == 1 end },
        { "css-lsp", condition = function() return vim.fn.executable "npm" == 1 end },
        { "tailwindcss-language-server", condition = function() return vim.fn.executable "npm" == 1 end },
      },
    },
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
      config = {
        cssls = { settings = { css = { lint = { unknownAtRules = "ignore" } } } },
      },
    },
  },
}
