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
  { "nextflow-io/vim-language-nextflow", ft = "nextflow" },
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
