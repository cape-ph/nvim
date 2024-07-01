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

  -- Add rainbow-delimiters.nvim for highlighting matching pairs of characters
  { import = "astrocommunity.editing-support.rainbow-delimiters-nvim" },

  -- Add nvim-bqf to improve the quickfix menu
  { import = "astrocommunity.debugging.nvim-bqf" },

  -- Add vim-sandwich operator for manipulating surrounding characters
  { import = "astrocommunity.syntax.vim-sandwich" },

  -- Add nvim-highlight-colors for better color highlighting
  { import = "astrocommunity.color.nvim-highlight-colors" },

  -- Add nvim-spectre for good search/replace
  { import = "astrocommunity.project.nvim-spectre" },

  -- Add vim-matchup for better % motion
  { import = "astrocommunity.motion.vim-matchup" },

  -- Add neogen for docstring generation
  { import = "astrocommunity.editing-support.neogen" },

  -- Add indent-tools.nvim for indent text object
  { import = "astrocommunity.indent.indent-tools-nvim" },

  -- Add neotest for more unit testing
  { import = "astrocommunity.test.neotest" },

  -- Add oversser for code execution
  { import = "astrocommunity.code-runner.overseer-nvim" },

  -- Use VS Code Icons
  { import = "astrocommunity.recipes.vscode-icons" },

  -- Show relative path in winbar
  { import = "astrocommunity.recipes.heirline-vscode-winbar" },

  -- Allow playing nicely with neovim vscode extension
  { import = "astrocommunity.recipes.vscode" },

  -- Add oil.nvim for more vim-like file management
  { import = "astrocommunity.file-explorer.oil-nvim" },
}
