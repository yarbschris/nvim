vim.cmd("let g:netrw_liststyle = 3")

local opt = vim.opt

opt.relativenumber = true

opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 2 spaces for tabs
opt.softtabstop = 4
opt.shiftwidth = 4 -- 4 spaces for indent:14
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting a new one
opt.smartindent = true

opt.wrap = false

-- search settings
opt.ignorecase = true -- search case insenstive
opt.smartcase = true -- case-sensitive if mixed case in search

opt.cursorline = true

opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

--backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line, or start pos

--clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

--split windows
opt.splitright = true -- split vertical window to right
opt.splitbelow = true -- split horizontal window to the bottom

--search
opt.hlsearch = false -- don't highlight all terms
opt.incsearch = true -- incremental search

--view
opt.scrolloff = 8
opt.signcolumn = "yes"

--Update Time
opt.updatetime = 50

--color column
opt.colorcolumn = "80"
