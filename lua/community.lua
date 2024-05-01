---@type LazySpec
return {
  -- Add AstroNvim Community Marketplace
  "AstroNvim/astrocommunity",

  -- Add Mason Tool Installer and initialize an empty ensure_installed list
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },
  { "mason-tool-installer.nvim", opts = { ensure_installed = {} } },

  -- Add conform.nvim for more stable formatting
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- Add conform.nvim for more stable linting
  { import = "astrocommunity.lsp.nvim-lint" },

  -- Show mode text in the statusline
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },

  -- Allow playing nicely with neovim vscode extension
  { import = "astrocommunity.recipes.vscode" },
}
