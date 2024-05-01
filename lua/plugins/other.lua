---@type LazySpec
return {
  {
    "mason-tool-installer.nvim",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, {
        "tree-sitter-cli", -- tree-sitter-cli for installing parsers automatically
      })
    end,
  },
  -- disabled plugins
  { "max397574/better-escape.nvim", enabled = false }, -- disable `jk` and `jj` for escape
  { "nvimtools/none-ls.nvim", enabled = false }, -- replaced with conform and nvim-lint
  { "jay-babu/mason-null-ls.nvim", enabled = false }, -- no longer needed
}
