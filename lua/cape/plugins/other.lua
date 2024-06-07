---@type LazySpec
return {
  {
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli", -- tree-sitter-cli for installing parsers automatically
        "typos-lsp", -- code spell checker
      },
    },
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
    "astroui",
    ---@type AstroUIOpts
    opts = {
      icons = {
        Clock = "", -- add icon for clock
      },
      status = {
        attributes = {
          mode = { bold = true }, -- bold mode/clock text
        },
      },
    },
  },
  {
    "heirline.nvim",
    opts = function(_, opts)
      local status = require "astroui.status"
      -- add the mode text with custom separator and bold highlighting
      opts.statusline[1] =
        status.component.mode { mode_text = { padding = { left = 1 } }, surround = { separator = { "", " " } } }
      -- add a clock to the right hand side
      opts.statusline[#opts.statusline] = status.component.builder {
        {
          provider = function()
            local time = os.date "%H:%M" -- show hour and minute in 24 hour format
            ---@cast time string
            return status.utils.stylize(time, {
              icon = { kind = "Clock", padding = { right = 1 } }, -- add icon
              padding = { right = 1 }, -- pad the right side
            })
          end,
        },
        update = { "ModeChanged", pattern = "*:*", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
        hl = status.hl.get_attributes "mode", -- highlight based on mode attributes
        surround = {
          separator = { " ", "" },
          color = status.hl.mode_bg,
          update = { "ModeChanged", pattern = "*:*" },
        }, -- background highlight based on mode
        init = status.init.update_events {
          { "User", pattern = "UpdateTime", callback = vim.schedule_wrap(function() vim.cmd.redrawstatus() end) },
        },
      }

      local uv = vim.uv or vim.loop
      uv.new_timer():start( -- timer for updating the time
        (60 - tonumber(os.date "%S")) * 1000, -- offset timer based on current seconds past the minute
        60000, -- update every 60 seconds
        vim.schedule_wrap(
          function() vim.api.nvim_exec_autocmds("User", { pattern = "UpdateTime", modeline = false }) end
        )
      )
    end,
  },
  -- disabled plugins
  { "indent-blankline.nvim", enabled = false }, -- indentation levels
  { "better-escape.nvim", enabled = false }, -- disable `jk` and `jj` for escape
  { "none-ls.nvim", enabled = false }, -- replaced with conform and nvim-lint
  { "mason-null-ls.nvim", enabled = false }, -- no longer needed
}
