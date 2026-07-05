vim.g.mapleader = " "

-- Core settings/keymaps/autocmds
require("core")

-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup("plugins", {
  lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
  checker = { enabled = true, notify = false },
  change_detection = { notify = false },
})
