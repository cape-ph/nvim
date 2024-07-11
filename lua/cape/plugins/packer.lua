--- Configure Packer HCL Language Support
--- Used with:
--- * AWS AMI creation

---@type LazySpec
return {
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
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "hcl",
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
  -- icons
  {
    "mini.icons",
    opts = {
      filetype = {
        ["hcl.packer"] = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
}
