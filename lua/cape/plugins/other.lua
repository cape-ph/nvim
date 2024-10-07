---@type LazySpec
return {
  {
    "nvim-bqf",
    opts = {
      preview = { auto_preview = false }, -- disable auto preview in quickfix
      func_map = { split = "-", vsplit = "|" }, -- remap split creation
    },
  },
  {
    "conform.nvim",
    opts = {
      formatters_by_ft = {
        ["*"] = function(bufnr)
          local buf_utils = require "astrocore.buffer"
          return buf_utils.is_valid(bufnr) and buf_utils.has_filetype(bufnr) and { "injected" } or {}
        end,
      },
    },
  },
  {
    "mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "tree-sitter-cli", -- tree-sitter-cli for installing parsers automatically
        "prettier", -- very general code formatter
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
  {
    "astrocore",
    opts = function(_, opts)
      -- set more default options
      local lvim = opts.options
      lvim.opt.list = true
      lvim.opt.listchars = { tab = "│→", extends = "⟩", precedes = "⟨", trail = "·", nbsp = "␣" }
      lvim.opt.showbreak = "↪ "

      -- by default only search through git files if in git directory
      opts.mappings.n["<Leader>ff"][1] = function()
        require("telescope.builtin").find_files {
          -- search all files if in git root
          hidden = vim.tbl_get((vim.uv or vim.loop).fs_stat ".git" or {}, "type") == "directory",
        }
      end

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
  {
    "neo-tree.nvim",
    opts = {
      default_component_configs = {
        indent = { with_expanders = true },
      },
      filesystem = {
        hijack_netrw_behavior = "disabled",
      },
      window = {
        mappings = {
          -- better split creation bindings
          ["\\"] = "open_split",
          ["|"] = "open_vsplit",
          -- better search and replace binding
          s = "noop",
          gS = "noop",
          S = "grug_far_replace",
        },
      },
    },
  },
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
    opts = function(_, opts)
      local get_icon, cmd = require("astroui").get_icon, require("astrocore").cmd

      -- git status cache
      local git_avail = vim.fn.executable "git" == 1
      local function parse_output(commands)
        local result, ret = cmd(commands, false), {}
        if result then
          for line in vim.gsplit(result, "\n", { plain = true, trimempty = true }) do
            ret[line:gsub("/$", "")] = true
          end
        end
        return ret
      end
      local git_status_index = function(self, key)
        local ignore = { "git", "-C", key, "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" }
        local tracked = { "git", "-C", key, "ls-tree", "HEAD", "--name-only" }
        local ret = { ignored = parse_output(ignore), tracked = parse_output(tracked) }
        rawset(self, key, ret)
        return ret
      end
      local new_git_status = function() return setmetatable({}, { __index = git_status_index }) end
      local git_status = new_git_status()
      -- clear git status cache on refresh
      local refresh = require("oil.actions").refresh
      local orig_refresh = refresh.callback
      refresh.callback = function(...)
        git_status = new_git_status()
        orig_refresh(...)
      end

      local columns = {
        icon = { "icon", default_file = get_icon "DefaultFile", directory = get_icon "FolderClosed" },
        permissions = { "permissions", highlight = "Type" },
        size = { "size", highlight = "String" },
        mtime = { "mtime", highlight = "Function" },
      }
      local simple, detailed = { columns.icon }, { columns.permissions, columns.size, columns.mtime, columns.icon }

      -- improve search/replace mappings
      opts.keymaps.S = opts.keymaps.gS
      opts.keymaps.gS = nil

      ---@type oil.setupOpts
      return require("astrocore").extend_tbl(opts, {
        columns = simple,
        skip_confirm_for_simple_edits = true,
        watch_for_changes = true,
        keymaps = {
          gd = {
            desc = "Toggle detailed file view",
            callback = function()
              require("oil").set_columns(#require("oil.config").columns == 1 and detailed or simple)
            end,
          },
          R = "actions.refresh",
          ["<Tab>"] = "actions.close",
        },
        lsp_file_methods = { autosave_changes = "unmodified" },
        view_options = {
          is_hidden_file = function(name, bufnr)
            local dir = require("oil").get_current_dir(bufnr)
            local is_hidden = vim.startswith(name, ".") and name ~= ".."
            -- if no local directory (e.g. for ssh connections), just hide dotfiles
            if not git_avail or not dir then return is_hidden end
            -- dotfiles are considered hidden unless tracked
            if is_hidden then
              return not git_status[dir].tracked[name]
            else
              -- Check if file is gitignored
              return git_status[dir].ignored[name]
            end
          end,
          is_always_hidden = function(name) return name == ".." end,
        },
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
