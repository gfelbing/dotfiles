-- nvim-tree suggestions
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- bootstarp package manager
local function bootstrap_pckr()
  local pckr_path = vim.fn.stdpath("data") .. "/pckr/pckr.nvim"

  if not (vim.uv or vim.loop).fs_stat(pckr_path) then
    vim.fn.system({
      'git',
      'clone',
      "--filter=blob:none",
      'https://github.com/lewis6991/pckr.nvim',
      pckr_path
    })
  end

  vim.opt.rtp:prepend(pckr_path)
end


bootstrap_pckr()

require('pckr').add{
  -- Package manager
  'wbthomason/packer.nvim';

  -- file tree explorer
  { 'nvim-tree/nvim-web-devicons', tag= "v0.*" };
  { 'nvim-tree/nvim-tree.lua', tag = "v1" };
  -- beautiful statusline
  { 'akinsho/bufferline.nvim', requires = 'kyazdani42/nvim-web-devicons' };
  -- git support
  'tpope/vim-fugitive';
  'airblade/vim-gitgutter';
  {
      "kdheepak/lazygit.nvim",
      -- optional for floating window border decoration
      requires = {
          "nvim-lua/plenary.nvim",
      },
  };

  --- programming
  'sebdah/vim-delve'; -- golang debug glv

  -- fix everything and also find the ball
  { 'nvim-telescope/telescope.nvim', requires = { { 'nvim-lua/plenary.nvim' } } };

  --- LSP
  'neovim/nvim-lspconfig'; -- Collection of configurations for built-in LSP client
  'hrsh7th/nvim-cmp'; -- Autocompletion plugin
  'folke/neodev.nvim'; -- vim lua dev support
  'hrsh7th/cmp-nvim-lsp'; -- LSP source for nvim-cmp
  'saadparwaiz1/cmp_luasnip'; -- Snippets source for nvim-cmp
  'L3MON4D3/LuaSnip'; -- Snippets plugin
  'buoto/gotests-vim'; -- test code generation for go
  'artempyanykh/marksman'; -- markdown

  -- syntax highlighting
  'jvirtanen/vim-hcl'; -- hashicorp hcl
  'udalov/kotlin-vim'; -- kotlin syntax highlighting

  -- debugging
  {
      'mfussenegger/nvim-dap',
      -- optional for floating window border decoration
      requires = {
        'nvim-neotest/nvim-nio',
        'rcarriga/nvim-dap-ui',
        'leoluz/nvim-dap-go',
      },
  };

  {
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
  };
}

require('config-general')
require('config-git')
require('config-lsp')
require('config-dap')
require('config-coverage')
