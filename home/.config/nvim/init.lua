local use = require('packer').use
require('packer').startup(function()
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- colors
  --use 'RRethy/nvim-base16'
  use 'NLKNguyen/papercolor-theme'

  -- file tree explorer
  use 'kyazdani42/nvim-tree.lua'
  -- beautiful statusline
  use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
  -- git support
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  --- programming
  use 'sebdah/vim-delve' -- golang debug glv

  -- fix everything and also find the ball
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { { 'nvim-lua/plenary.nvim' } } }

  --- LSP
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'folke/lua-dev.nvim' -- vim lua dev support
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'valentjn/ltex-ls' -- latex/markdown
  use 'buoto/gotests-vim' -- test code generation for go

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
      require("user.coverage")
    end,
  })
end)

require('config-general')
require('config-lsp')
require('config-dap')
require('config-coverage')
