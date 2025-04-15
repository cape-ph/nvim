--- Configure Markdown Language Support
--- Used with:
--- * READMEs in repositories
--- * General notes

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "markdown",
        "markdown_inline",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "marksman",
      },
    },
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
      formatters = {
        prettier = {
          options = {
            ft_parsers = { markdown = "markdown" },
          },
        },
      },
    },
  },
  {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        extensions = {
          qmd = "markdown",
        },
      },
    },
  },
}
