-- Bootstrap packer.nvim if it's not already installed
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data").."/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
      "git", "clone", "--depth", "1",
      "https://github.com/wbthomason/packer.nvim",
      install_path
    })
    vim.cmd("packadd packer.nvim")
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Plugin setup using packer
require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- packer manages itself
  use "tpope/vim-fugitive"
  use "preservim/nerdtree"
  use "nvim-lua/plenary.nvim"
  use { "nvim-telescope/telescope.nvim", tag = "0.1.8" }

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Autocmd: open NERDTree on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NERDTree")
  end
})

-- Clipboard and UI settings
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true

-- Telescope keymaps
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
