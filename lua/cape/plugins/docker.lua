--- Configure Docker Support
--- Used with:
--- * AWS Glue ETL development

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = {
      ensure_installed = {
        "dockerfile",
      },
    },
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      if vim.fn.executable "npm" == 1 then
        vim.list_extend(opts.ensure_installed, {
          "dockerfile-language-server",
        })
      end
    end,
  },
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      filetypes = {
        filename = {
          ["docker-compose.yml"] = "yaml.docker-compose",
          ["docker-compose.yaml"] = "yaml.docker-compose",
        },
      },
    },
  },
}
