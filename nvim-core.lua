vim.cmd("syntax on")

-- Options
vim.o.clipboard = "unnamedplus"
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Colorscheme, from scratch: black background, gray UI,
-- dark accents used only as foregrounds with semantic meaning
vim.o.background = "dark"

local p = {
  black  = "#000000",
  red    = "#8b1a1a",
  green  = "#1a6b1a",
  blue   = "#2a4a9b",
  yellow = "#8b8b1a",
  orange = "#a05a1a",
  violet = "#6a1a8b",
  fg     = "#bbbbbb",
  gray   = "#888888",
  dim    = "#4a4a4a",
  faint  = "#333333",
  bg1    = "#0d0d0d",
  bg2    = "#1e1e1e",
}

local function hl(group, opts) vim.api.nvim_set_hl(0, group, opts) end

-- UI
hl("Normal",       { fg = p.fg, bg = p.black })
hl("NormalFloat",  { fg = p.fg, bg = p.bg1 })
hl("CursorLine",   { bg = p.bg1 })
hl("CursorLineNr", { fg = p.gray })
hl("LineNr",       { fg = p.faint })
hl("SignColumn",   { bg = p.black })
hl("WinSeparator", { fg = p.bg2, bg = p.black })
hl("StatusLine",   { fg = p.fg, bg = p.bg1 })
hl("StatusLineNC", { fg = p.dim, bg = p.bg1 })
hl("Pmenu",        { fg = p.fg, bg = p.bg1 })
hl("PmenuSel",     { fg = "#ffffff", bg = p.bg2 })
hl("Visual",       { bg = p.bg2 })
hl("Search",       { fg = "#ffffff", bg = p.faint })
hl("IncSearch",    { fg = p.black, bg = p.gray })
hl("MatchParen",   { bg = p.faint })
hl("NonText",      { fg = "#222222" })
hl("Whitespace",   { fg = "#222222" })
hl("Folded",       { fg = p.dim, bg = p.bg1 })
hl("Directory",    { fg = p.blue })
hl("Title",        { fg = p.fg })
hl("ErrorMsg",     { fg = p.red })
hl("WarningMsg",   { fg = p.orange })
hl("MoreMsg",      { fg = p.green })
hl("Question",     { fg = p.green })

-- Syntax
hl("Comment",    { fg = p.dim })
hl("String",     { fg = p.green })
hl("Character",  { link = "String" })
hl("Constant",   { fg = p.yellow })
hl("Number",     { fg = p.yellow })
hl("Boolean",    { fg = p.yellow })
hl("Float",      { link = "Number" })
hl("Identifier", { fg = p.gray })
hl("Function",   { fg = p.blue })
hl("Statement",  { fg = p.violet })
hl("Keyword",    { fg = p.violet })
hl("Operator",   { fg = p.gray })
hl("Type",       { fg = p.orange })
hl("PreProc",    { fg = p.violet })
hl("Special",    { fg = p.gray })
hl("Todo",       { fg = p.yellow, bg = p.black })
hl("Error",      { fg = p.red, bg = p.black })
hl("Underlined", { fg = p.blue, underline = true })

-- Diagnostics
hl("DiagnosticError", { fg = p.red })
hl("DiagnosticWarn",  { fg = p.orange })
hl("DiagnosticInfo",  { fg = p.blue })
hl("DiagnosticHint",  { fg = p.dim })

-- Diff
hl("DiffAdd",    { fg = p.green, bg = p.black })
hl("DiffDelete", { fg = p.red, bg = p.black })
hl("DiffChange", { fg = p.yellow, bg = p.black })
hl("DiffText",   { fg = p.yellow, bg = p.faint })

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
