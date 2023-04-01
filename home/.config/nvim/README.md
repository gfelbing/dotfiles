# lua config for neovim

## requirements

The following external tools need to be in path:

- [terraform-lsp](https://github.com/juliosueiras/terraform-lsp)
- [ag](https://github.com/ggreer/the_silver_searcher)
- [golangci-lint-langserver](https://github.com/nametake/golangci-lint-langserver)
- [gopls](https://github.com/golang/tools/tree/master/gopls)
- vscode-css-language-server
- vscode-html-language-server
- bufls `go install github.com/bufbuild/buf-language-server/cmd/bufls@latest`
- TODO: append lsp servers

## setup

```
:PackerUpdate
```

## configuration

Well, it's lua configuration already. But you might want to customize [keymaps](./lua/config-keys.lua)
