---@type LazySpec
return {
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        ["*"] = function(bufnr) return require("astrocore.buffer").is_valid(bufnr) and { "injected" } or {} end,
      },
    },
  },
  {
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli", -- tree-sitter-cli for installing parsers automatically
      },
    },
  },
  {
    "astrolsp",
    opts = {
      config = {
        typos_lsp = { single_file_support = false },
      },
    },
  },
  { -- add some sane missing text objects
    "astrocore",
    opts = function(_, opts)
      -- add line text object
      for lhs, rhs in pairs {
        il = { ":<C-u>normal! $v^<CR>", desc = "inside line" },
        al = { ":<C-u>normal! V<CR>", desc = "around line" },
      } do
        opts.mappings.o[lhs] = rhs
        opts.mappings.x[lhs] = rhs
      end

      -- add missing in between and around two character pairs
      for _, char in ipairs { "_", "-", ".", ":", ",", ";", "|", "/", "\\", "*", "+", "%", "`", "?" } do
        for lhs, rhs in pairs {
          ["i" .. char] = {
            (":<C-u>silent! normal! f%sF%slvt%s<CR>"):format(char, char, char),
            desc = "inside " .. char,
          },
          ["a" .. char] = {
            (":<C-u>silent! normal! f%sF%svf%s<CR>"):format(char, char, char),
            desc = "around " .. char,
          },
        } do
          opts.mappings.o[lhs] = rhs
          opts.mappings.x[lhs] = rhs
        end
      end
    end,
  },
  -- disable netrw hijacking of neo-tree
  { "neo-tree.nvim", opts = { filesystem = { hijack_netrw_behavior = "disabled" } } },
  -- setup oil file manager
  {
    "oil.nvim",
    init = function() -- start oil on startup lazily if necessary
      if vim.fn.argc() == 1 then
        local arg = vim.fn.argv(0)
        ---@cast arg string
        local stat = vim.loop.fs_stat(arg)
        local adapter = string.match(arg, "^([%l-]*)://")
        if (stat and stat.type == "directory") or adapter == "oil-ssh" then require "oil" end
      end
    end,
    dependencies = {
      "astrocore",
      opts = {
        autocmds = {
          -- start oil when editing a directory
          neotree_start = false,
          oil_start = {
            {
              event = "BufNew",
              desc = "start oil when editing a directory",
              callback = function()
                if package.loaded["oil"] then
                  vim.api.nvim_del_augroup_by_name "oil_start"
                elseif vim.fn.isdirectory(vim.fn.expand "<afile>") == 1 then
                  require("lazy").load { plugins = { "oil.nvim" } }
                  vim.api.nvim_del_augroup_by_name "oil_start"
                end
              end,
            },
          },
        },
        mappings = {
          n = {
            ["<Tab>"] = { "<Cmd>Oil<CR>", desc = "Oil Filebrowser" },
          },
        },
      },
    },
    opts = {
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      keymaps = {
        ["<Tab>"] = "actions.close",
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
