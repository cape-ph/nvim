--- Configure Nextflow Language Support
--- Used with:
--- * Pipeline development

---@type LazySpec
return {
  { -- Set up filetypes
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = { filetypes = { extension = {
      nf = "nextflow",
      ["nf.test"] = "nextflow",
    } } },
  },
  { -- Syntax highlighting
    "nextflow-io/vim-language-nextflow",
    ft = "nextflow",
  },
  { -- Tools to be installed
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        { "nextflow-language-server", condition = function() return vim.fn.executable "java" == 1 end },
      },
    },
  },
  { -- add nextflow_ls to mason-lspconfig
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mason_lspconfig = {
        servers = {
          nextflow_ls = {
            package = "nextflow-language-server",
            filetypes = { "nextflow" },
            config = {
              cmd = { "nextflow-language-server" },
            },
          },
        },
      },
    },
  },
  { -- Icons
    "echasnovski/mini.icons",
    optional = true,
    opts = {
      filetype = {
        nextflow = { glyph = "󰉛", hl = "MiniIconsGreen" },
      },
    },
  },
}
