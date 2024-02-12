-- nvim-tree suggestions
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


local use = require('packer').use
require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- file tree explorer
  use 'kyazdani42/nvim-tree.lua'
  -- beautiful statusline
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  -- git support
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'
  use({
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  })

  --- programming
  use 'sebdah/vim-delve' -- golang debug glv

  -- fix everything and also find the ball
  use { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } }

  --- LSP
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'folke/neodev.nvim' -- vim lua dev support
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'buoto/gotests-vim' -- test code generation for go
  use 'artempyanykh/marksman' -- markdown

  -- syntax highlighting
  use 'jvirtanen/vim-hcl' -- hashicorp hcl
  use 'udalov/kotlin-vim' -- kotlin syntax highlighting

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'leoluz/nvim-dap-go'

  use({
    "andythigpen/nvim-coverage",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("coverage").setup({
        commands = true, -- create commands
        highlights = {
          -- customize highlight groups created by the plugin
          covered = { fg = "#007804" },   -- supports style, fg, bg, sp (see :h highlight-gui)
          uncovered = { fg = "#eb1f00" },
        },
        signs = {
          -- use your own highlight groups or text markers
          covered = { hl = "CoverageCovered", text = "✓" },
          uncovered = { hl = "CoverageUncovered", text = "✗" },
        },
        summary = {
          -- customize the summary pop-up
          min_coverage = 80.0,      -- minimum coverage threshold (used for highlighting)
        },
        lang = {
          -- customize language specific settings
        },
      })
    end,
  })
end)

require('config-general')
require('config-git')
require('config-lsp')
require('config-dap')
require('config-coverage')
