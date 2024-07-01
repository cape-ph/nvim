--- Configure Packer HCL Language Support
--- Used with:
--- * AWS AMI creation

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
      },
    },
  },
  {
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        pattern = {
          [".*%.pkr%.hcl"] = "hcl.packer",
        },
      },
    },
  },
  { -- Linters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        packer = { "packer_fmt" },
      },
    },
  },
}
