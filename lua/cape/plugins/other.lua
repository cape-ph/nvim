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
  -- set up header
  {
    "alpha-nvim",
    opts = function(_, opts)
      opts.section.header.val = {
        " ██████  █████  ██████  ███████",
        "██      ██   ██ ██   ██ ██",
        "██      ███████ ██████  █████",
        "██      ██   ██ ██      ██",
        " ██████ ██   ██ ██      ███████",
        " ",
        "███    ██ ██    ██ ██ ███    ███",
        "████   ██ ██    ██ ██ ████  ████",
        "██ ██  ██ ██    ██ ██ ██ ████ ██",
        "██  ██ ██  ██  ██  ██ ██  ██  ██",
        "██   ████   ████   ██ ██      ██",
      }
      local leader = ({ [""] = "\\", [" "] = "<Space>" })[vim.g.mapleader] or vim.g.mapleader or "\\"
      opts.section.footer.val = { "When in doubt, press " .. leader }
    end,
    config = function(_, opts) require("alpha").setup(opts.config) end,
  },
  -- setup custom left only mode text indicator
  {
    "heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      opts.statusline[1] = status.component.mode {
        mode_text = { padding = { left = 1 } },
        hl = { bold = true },
        surround = { separator = { "", " " } },
      } -- add the mode text with custom separator and bold highlighting
      opts.statusline[#opts.statusline] = nil -- remove right mode indicator
    end,
  },
  -- disabled plugins
  { "indent-blankline.nvim", enabled = false }, -- indentation levels
  { "better-escape.nvim", enabled = false }, -- disable `jk` and `jj` for escape
  { "none-ls.nvim", enabled = false }, -- replaced with conform and nvim-lint
  { "mason-null-ls.nvim", enabled = false }, -- no longer needed
}
