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
    opts = function(_, opts)
      if vim.fn.executable "npm" == 1 then
        vim.list_extend(opts.ensure_installed, {
          "bash-language-server",
          "bash-debug-adapter",
        })
      end
      vim.list_extend(opts.ensure_installed, {
        "shellcheck",
        "shfmt",
      })
    end,
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
