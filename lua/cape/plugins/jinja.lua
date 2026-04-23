--- Configure Jinja Template Support
--- Used with:
--- * EC2 Instance Configuration

---@type LazySpec
return {
  { -- Treesitter parsers to be installed and filetypes
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = { extension = {
        j2 = "jinja",
        jinja2 = "jinja",
        jinja = "jinja",
      } },
      treesitter = { ensure_installed = {
        "jinja",
        "jinja_inline",
      } },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        { "jinja-lsp", condition = function() return vim.fn.executable "cargo" == 1 end },
      },
    },
  },
}
