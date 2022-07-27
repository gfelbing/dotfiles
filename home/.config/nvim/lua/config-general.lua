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

vim.api.nvim_set_keymap("n", keys.Find.File, ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", keys.Find.Buffer, ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", keys.Find.Grep, ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", keys.Find.Command, ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.cmd("let g:ackprg = 'ag --vimgrep'")


require("bufferline").setup {}

-- file explorer → nvim-tree
require("nvim-tree").setup()
vim.api.nvim_set_keymap("n", keys.Tree.Toggle, ':NvimTreeToggle<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", keys.Tree.Find, ':NvimTreeFindFileToggle<CR>', {noremap=true, silent=true})

