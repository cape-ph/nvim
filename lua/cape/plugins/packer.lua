--- Configure Packer HCL Language Support
--- Used with:
--- * AWS AMI creation

---@type LazySpec
return {
  { -- Treesitter parsers to be installed and filetypes
    "astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = { pattern = {
        [".*%.pkr.*%.hcl"] = "hcl.packer",
      } },
      treesitter = { ensure_installed = {
        "hcl",
      } },
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
  { -- Icons
    "mini.icons",
    opts = {
      filetype = {
        ["hcl.packer"] = { glyph = "", hl = "MiniIconsAzure" },
      },
    },
  },
}
