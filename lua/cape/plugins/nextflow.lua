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
        {
          "nextflow-language-server",
          condition = function()
            local version_output = vim.fn.executable "java" == 1
              and require("astrocore").cmd({ "java", "-version" }, false)
            if version_output then
              local version = version_output:match '"([%.%d]+)"'
              if version then
                local version_compared, version_valid = pcall(vim.version.ge, version, "17")
                if version_compared then
                  return version_valid
                else
                  vim.notify(
                    "Unable to validate Java version, open issue if occurs with the detected version: `"
                      .. version
                      .. "`",
                    vim.log.levels.ERROR
                  )
                end
              else
                vim.notify(
                  "Unable to identify Java version, open issue if occurs with the following information: \n```\n"
                    .. version_output
                    .. "\n```",
                  vim.log.levels.ERROR
                )
              end
            end
            return false
          end,
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
