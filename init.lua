-- Download and setup the lazy.nvim plugin manager
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup {
  -- Add AstroNvim and import the plugins it provides
  { "AstroNvim/AstroNvim", version = "^4", import = "astronvim.plugins" },
  -- Load AstroNvim community marketplace plugins before user plugins
  { import = "community" },
  -- Load user plugins last
  { import = "plugins" },
}
