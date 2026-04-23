--- Configure Docker Support
--- Used with:
--- * AWS Glue ETL development

---@type LazySpec
return {
  { -- Treesitter parsers to be installed and filetypes
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        filename = {
          ["docker-compose.yml"] = "yaml.docker-compose",
          ["docker-compose.yaml"] = "yaml.docker-compose",
        },
      },
      treesitter = { ensure_installed = {
        "dockerfile",
      } },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        { "dockerfile-language-server", condition = function() return vim.fn.executable "npm" == 1 end },
      },
    },
  },
}
