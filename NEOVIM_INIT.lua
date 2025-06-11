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

require("packer").startup(function(use)
  use "wbthomason/packer.nvim"
  use "tpope/vim-fugitive"
  use "preservim/nerdtree"
  use "nvim-lua/plenary.nvim"
  use { "nvim-telescope/telescope.nvim", tag = "0.1.8" }
  if packer_bootstrap then
    require("packer").sync()
  end
end)

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NERDTree")
  end
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    local tabs = vim.fn.tabpagenr('$')
    if #buffers == 1 and vim.bo.filetype == "nerdtree" and tabs == 1 then
      vim.cmd("quit")
    end
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nerdtree",
  callback = function()
    vim.defer_fn(function()
      vim.cmd("wincmd l")
    end, 10)
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function()
    local wins = vim.api.nvim_list_wins()
    local nerdtree_only = true
    for _, win in ipairs(wins) do
      local buf = vim.api.nvim_win_get_buf(win)
      local ft = vim.api.nvim_buf_get_option(buf, "filetype")
      if ft ~= "nerdtree" then
        nerdtree_only = false
        break
      end
    end
    if nerdtree_only then
      vim.cmd("quit")
    end
  end
})

vim.keymap.set('n', '<leader>t', function()
  vim.cmd('botright 15split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { noremap = true, silent = true, desc = "TERMINAL OPENED!!" })

vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true

vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
