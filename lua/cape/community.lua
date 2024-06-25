---@type LazySpec
return {
  -- Add AstroNvim Community Marketplace
  "AstroNvim/astrocommunity",

  -- Add Mason Tool Installer and initialize an empty ensure_installed list
  { import = "astrocommunity.utility.mason-tool-installer-nvim" },

  -- Add conform.nvim for more stable formatting
  { import = "astrocommunity.editing-support.conform-nvim" },

  -- Add conform.nvim for more stable linting
  { import = "astrocommunity.lsp.nvim-lint" },

  -- Add neotest for more unit testing
  { import = "astrocommunity.test.neotest" },

  -- Use VS Code Icons
  { import = "astrocommunity.recipes.vscode-icons" },

  -- Show relative path in winbar
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },

  -- Allow playing nicely with neovim vscode extension
  { import = "astrocommunity.recipes.vscode" },

  -- Add oil.nvim for more vim-like file management
  { import = "astrocommunity.file-explorer.oil-nvim" },
}
