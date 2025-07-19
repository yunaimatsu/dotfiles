local bg_color = '#444444'
-- local font_color = vim.fn.expand('#333333')

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
  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn['mkdp#util#install']() end,
    ft = { "markdown" },
  })
  if packer_bootstrap then
    require("packer").sync()
  end
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use 'folke/tokyonight.nvim'
  use 'neovim/nvim-lspconfig'           -- LSPの設定を簡単にするプラグイン
  use 'williamboman/mason.nvim'         -- LSPサーバーやツールのインストーラ（管理ツール）
  use 'williamboman/mason-lspconfig.nvim' -- masonとlspconfigの連携
  use 'hrsh7th/nvim-cmp'                -- 補完エンジン本体
  use 'hrsh7th/cmp-nvim-lsp'            -- LSP補完ソース
  use 'hrsh7th/cmp-buffer'              -- バッファ内補完
  use 'hrsh7th/cmp-path'                -- パス補完
  use 'hrsh7th/cmp-cmdline'             -- コマンドライン補完
  use 'saadparwaiz1/cmp_luasnip'        -- スニペット補完
  use 'L3MON4D3/LuaSnip'                -- スニペットエンジン
end)

-- Neovim Core API
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

vim.cmd('syntax on')

-- Keymap
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('botright 15split')
  vim.cmd('terminal')
  vim.cmd('startinsert')
end, { noremap = true, silent = true, desc = "TERMINAL OPENED!!" })

-- Vim Options
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })

-- Vim Buffer Options
-- Vim Window Options

-- Vim Keymap
vim.keymap.set({'n', 'i', 'v'}, '<C-a>', '<Home>', { noremap = true, silent = true, desc = "Jump to beginning of line" })
vim.keymap.set({'n', 'i', 'v'}, '<C-e>', '<End>', { noremap = true, silent = true, desc = "Jump to end of line" })
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })
vim.keymap.set('i', '<C-g>', '<Esc>', { noremap = true, silent = true, desc = "Exit insert mode with Ctrl+G" })

-- Global variables
vim.g.mkdp_auto_close = 1      
vim.g.mkdp_browser = "chromium"

-- Opt 
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

require('nvim-treesitter.configs').setup {
  ensure_installed = { "javascript", "typescript", "json" },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
vim.cmd [[colorscheme tokyonight]]
