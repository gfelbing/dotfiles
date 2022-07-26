local keys = require("config-keys")

-- general vim settings
vim.wo.number = true
-- On pressing tab, insert 2 spaces
vim.api.nvim_set_option('expandtab', true)
-- show existing tab with 2 spaces width
vim.api.nvim_set_option('tabstop', 2)
vim.api.nvim_set_option('softtabstop', 2)
-- when indenting with '>', use 2 spaces width
vim.api.nvim_set_option('shiftwidth', 2)

-- colors
vim.cmd("set background=light")
vim.cmd("colorscheme PaperColor")

-- buffers
vim.api.nvim_set_keymap("n", keys.Buffer.Next, ':bn<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", keys.Buffer.Previous, ':bp<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", keys.Buffer.Delete, ':bd<CR>', { noremap = true, silent = true })

-- thanks https://blog.ploth.xyz/blog/2017/11/04/vim-search-like-a-boss.html
-- searching → fzf / ag
vim.api.nvim_set_keymap("n", keys.FindFile, ':FZF<CR>', { noremap = true, silent = true })
vim.cmd("let g:ackprg = 'ag --vimgrep'")

require("bufferline").setup {}

-- file explorer → nvim-tree
require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", keys.Tree.Toggle, ':NvimTreeToggle<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", keys.Tree.Find, ':NvimTreeFindFileToggle<CR>', {noremap=true, silent=true})

