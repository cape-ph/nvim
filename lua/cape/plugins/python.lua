--- Configure Python Language Support
--- Used with:
--- * Pulumi, infrastructure as code
--- * AWS Lambda/Glue, data processing scripts

---@type LazySpec
return {
  { -- Treesitter parsers to be installed
    "nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "python",
      })
    end,
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "black",
        "isort",
        "debugpy",
      })
    end,
  },
  { -- Formatters to use
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        python = { "isort", "black" },
      },
    },
  },
  { -- Tool to change virtual environments
    "linux-cultist/venv-selector.nvim",
    cmd = { "VenvSelect", "VenvSelectCached" },
    dependencies = {
      {
        "astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>v"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
            },
          },
        },
      },
      { -- make virutal environment clickable to change
        "heirline.nvim",
        opts = function(_, opts)
          opts.statusline[10] = require("astroui.status").component.virtual_env {
            on_click = {
              name = "heirline_virtual_env",
              callback = function() vim.schedule(vim.cmd.VenvSelect) end,
            },
          }
        end,
      },
    },
    opts = {
      name = { "env", ".env", "venv", ".venv" },
      notify_user_on_activate = false,
      parents = 0,
    },
  },
  {
    "astrolsp",
    ---@type AstroLSPOpts
    opts = {
      ---@diagnostic disable: missing-fields
      config = {
        pyright = {
          before_init = function(_, c)
            if not c.settings then c.settings = {} end
            if not c.settings.python then c.settings.python = {} end
            c.settings.python.pythonPath = vim.fn.exepath "python"
          end,
          settings = {
            python = {
              analysis = {
                typeCheckingMode = "off", -- disable typechecking as it's not super great
              },
            },
          },
        },
      },
    },
  },
}
