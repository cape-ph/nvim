--- Configure Shell Language Support
--- Used with:
--- * System administration scripts

---@type LazySpec
return {
  {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        pattern = {
          ["%.env%.[%w_.-]+"] = "sh",
        },
      },
    },
  },
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "shellcheck", -- used by bash language server
        "shfmt",
        "bash-debug-adapter",
      },
    },
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        sh = { "shfmt" },
      },
    },
  },
}
