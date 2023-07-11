-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local keys = require("config-keys")
local opts = { noremap = true, silent = true }
vim.keymap.set('n', keys.Lsp.Diagnostics.Open, vim.diagnostic.open_float, opts)
vim.keymap.set('n', keys.Lsp.Diagnostics.Next, vim.diagnostic.goto_next, opts)
vim.keymap.set('n', keys.Lsp.Diagnostics.List, vim.diagnostic.setloclist, opts)

vim.keymap.set("n", keys.Find.Reference, ':Telescope lsp_references<CR>', opts)
vim.keymap.set("n", keys.Find.Symbol, ':Telescope lsp_dynamic_workspace_symbols<CR>', opts)
vim.keymap.set("n", keys.Find.Reference, ':Telescope lsp_references<CR>', opts)
vim.keymap.set("n", keys.Find.Implementation, ':Telescope lsp_implementations<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(_, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', keys.Lsp.GoTo.Declaration, vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', keys.Lsp.GoTo.Definition, vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', keys.Lsp.GoTo.Implementation, vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', keys.Lsp.GoTo.References, vim.lsp.buf.references, bufopts)

  vim.keymap.set('n', keys.Lsp.Hover.Description, vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', keys.Lsp.Hover.Signature, vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', keys.Lsp.Hover.Definition, vim.lsp.buf.type_definition, bufopts)

  vim.keymap.set('n', keys.Lsp.Workspace.AddFolder, vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', keys.Lsp.Workspace.RemoveFolder, vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', keys.Lsp.Workspace.ListFolders, function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)

  vim.keymap.set('n', keys.Lsp.Refactor.Rename, vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', keys.Lsp.Refactor.CodeAction, vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', keys.Lsp.Refactor.Format, function()
      vim.lsp.buf.format { async = true }
  end, bufopts)
end

local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- IMPORTANT: make sure to setup neodev BEFORE lspconfig
require("neodev").setup({
  lspconfig = {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
})
local lspconfig = require('lspconfig')

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- lspconfigs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- lsp's with default setup
local servers = { 'pyright', 'tsserver', 'gopls', 'golangci_lint_ls', 'marksman', 'terraform_lsp', 'bufls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags,
  }
end
lspconfig.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
  flags = lsp_flags,
  root_dir = function(fname)
    return lspconfig.util.root_pattern('go.work', 'go.mod', '.git')(fname)
  end,
}
-- setup sumneko and enable call snippets
lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      completion = {
        callSnippet = "Replace"
      }
    }
  }
})

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    [keys.Lsp.Completion.Run] = cmp.mapping.complete(),
    [keys.Lsp.Completion.Confirm] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    [keys.Lsp.Completion.Next] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    [keys.Lsp.Completion.Previous] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
