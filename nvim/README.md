## ゴール（移行後の状態）ぺこ

* プラグイン管理：**lazy.nvim**
* 状態固定：**`lazy-lock.json` をGit管理**（別環境で同じコミットに固定）ぺこ

## 1. ディレクトリ構成を作るぺこ（推奨の最小分割）ぺこ

dotfiles 側をこうするのが最も破綻しにくいですぺこ：

```text
~/working/dotfiles/nvim/.config/nvim/
├── init.lua
└── lua/
    ├── core.lua
    └── plugins.lua
```

シムリンクはディレクトリ単位推奨ぺこ：

```sh
mkdir -p ~/.config
ln -sfn ~/working/dotfiles/nvim/.config/nvim ~/.config/nvim
```

※ すでに `~/.config/nvim` があるなら、退避してからが安全ぺこ：

```sh
mv ~/.config/nvim ~/.config/nvim.bak.$(date +%Y%m%d%H%M%S)
ln -sfn ~/working/dotfiles/nvim/.config/nvim ~/.config/nvim
```

---

## 2. packer を無効化（削除）ぺこ

lazy.nvim に移行したら packer は不要ですぺこ。
Git 管理の設定から packer 記述を消すのは後述のファイル置換で完了ぺこ。

ローカルに残っている packer 本体も消してよいですぺこ（任意）：

```sh
rm -rf ~/.local/share/nvim/site/pack/packer
rm -rf ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

---

## 3. 新しい設定ファイル（コピペで完成）ぺこ

### 3.1 `~/.config/nvim/init.lua` ぺこ

```lua
-- ~/.config/nvim/init.lua
-- Entry point: minimal + fast (lazy.nvim)

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
```

---

### 3.2 `~/.config/nvim/lua/core.lua` ぺこ

※ ここに「元init.luaのプラグイン以外」を集約ぺこ。
NERDTree autocmd / keymaps / options / colorscheme 適用など全部ここですぺこ。

```lua
-- ~/.config/nvim/lua/core.lua

-- Use environment variables for theme colors
local bg_color = os.getenv("COLOR_BG_LIGHTER") or "#444444"

vim.cmd("syntax on")

-- Options
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.api.nvim_set_hl(0, "Normal", { bg = bg_color })

-- Global variables
vim.g.mkdp_auto_close = 1
vim.g.mkdp_browser = "chromium"

-- Autocmds: NERDTree
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.cmd("NERDTree")
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    local buffers = vim.fn.getbufinfo({ buflisted = 1 })
    local tabs = vim.fn.tabpagenr("$")
    if #buffers == 1 and vim.bo.filetype == "nerdtree" and tabs == 1 then
      vim.cmd("quit")
    end
  end,
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
  end,
})

-- Keymaps
vim.keymap.set({ "n", "i", "v" }, "<C-a>", "<Home>", { noremap = true, silent = true, desc = "BOL" })
vim.keymap.set({ "n", "i", "v" }, "<C-e>", "<End>",  { noremap = true, silent = true, desc = "EOL" })

vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

vim.keymap.set("i", "<M-g>", "<Esc>", { noremap = true, silent = true, desc = "Exit insert mode" })

-- Terminal toggle with Super+\  (note: <D-...> depends on your terminal/OS sending meta)
vim.keymap.set("n", "<D-\\>", function()
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[buf].buftype == "terminal" then
      local wins = vim.fn.win_findbuf(buf)
      if #wins > 0 then
        vim.api.nvim_win_close(wins[1], true)
        return
      else
        vim.cmd("botright 15split")
        vim.api.nvim_win_set_buf(0, buf)
        vim.cmd("startinsert")
        return
      end
    end
  end
  vim.cmd("botright 15split")
  vim.cmd("terminal")
  vim.cmd("startinsert")
end, { noremap = true, silent = true, desc = "Toggle terminal" })

-- Exit terminal mode
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true, silent = true })

-- Window move (Super+h/j/k/l)
vim.keymap.set("n", "<D-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<D-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<D-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<D-l>", "<C-w>l", { noremap = true, silent = true })

vim.keymap.set("t", "<D-h>", [[<C-\><C-n><C-w>h]], { noremap = true, silent = true })
vim.keymap.set("t", "<D-j>", [[<C-\><C-n><C-w>j]], { noremap = true, silent = true })
vim.keymap.set("t", "<D-k>", [[<C-\><C-n><C-w>k]], { noremap = true, silent = true })
vim.keymap.set("t", "<D-l>", [[<C-\><C-n><C-w>l]], { noremap = true, silent = true })
```

---

### 3.3 `~/.config/nvim/lua/plugins.lua` ぺこ

ここが **lazy.nvim の宣言**ですぺこ。
packer's `use` を **lazy spec**へ置換していますぺこ。

```lua
-- ~/.config/nvim/lua/plugins.lua
return {
  -- Theme
  {
    "folke/tokyonight.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight]])
    end,
  },

  -- Git
  { "tpope/vim-fugitive" },

  -- File tree (keep NERDTree as-is to match current behavior)
  { "preservim/nerdtree" },

  -- Telescope
  { "nvim-lua/plenary.nvim" },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
  },

  -- Markdown preview (build step needed)
  {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "javascript", "typescript", "json" },
        highlight = { enable = true, additional_vim_regex_highlighting = false },
      })
    end,
  },

  -- LSP stack
  { "neovim/nvim-lspconfig" },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    config = function()
      require("mason-lspconfig").setup()

      -- minimal example: you can extend servers later
      local lspconfig = require("lspconfig")
      -- Example: enable lua_ls if installed
      if lspconfig.lua_ls then
        lspconfig.lua_ls.setup({})
      end
    end,
  },

  -- Completion (nvim-cmp + LuaSnip)
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
          { name = "buffer" },
        }),
      })

      -- cmdline completion
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
}
```

---

## 4. 初回起動で `lazy-lock.json` を生成して Git 管理ぺこ

1. Neovim 起動ぺこ：

```sh
nvim
```

2. lazy が自動インストール→プラグイン install ぺこ。
   不安なら `:Lazy` で状態確認ぺこ。

3. `lazy-lock.json` が `~/.config/nvim/lazy-lock.json` に生成されますぺこ。
   dotfiles で管理するなら **必ずコミット**ぺこ。

---

## 5. 依存パッケージ（Arch）ぺこ

最低限これを入れておくと「別環境移植」が安定しますぺこ：

```sh
sudo pacman -S --needed neovim git ripgrep fd unzip base-devel nodejs npm
```

---

## 6. 移行後に動作確認するチェックリストぺこ

Neovim で以下を確認ぺこ：

* `:Lazy` が開くぺこ
* `:Telescope find_files` が動くぺこ（ripgrep/fd が無いと一部機能が弱い）ぺこ
* 起動時に NERDTree が開くぺこ
* `:TSInstall javascript` 等が動くぺこ
* `:Mason` が開くぺこ
* Insert時に補完候補が出るぺこ

---

## 7. 次の改善ポイント（最短で効く順）ぺこ

これは“今すぐ必須”ではないですが、最もモダンに寄せるなら順にこうですぺこ：

1. NERDTree → **nvim-tree** or **neo-tree**（NERDTreeは実質レガシー寄り）ぺこ
2. LSP server の自動セットアップ（mason-lspconfig の handlers）ぺこ
3. `core.lua` を `options.lua` / `keymaps.lua` / `autocmds.lua` に分割ぺこ

---

この状態で、あなたの要求「lazy.nvim に移行＋lazy-lock.json 採用」は完了ですぺこ。
次に、**あなたの主用途（TS/Go/Pythonなど）に合わせて LSP と formatter を最小・高速に確定**させるところまでやりますぺこ。

