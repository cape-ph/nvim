--- Configure Markdown Language Support
--- Used with:
--- * READMEs in repositories
--- * General notes

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "markdown",
        "markdown_inline",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "marksman",
        "prettier",
      })
    end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
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
