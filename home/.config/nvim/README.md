# lua config for neovim

## requirements

The following external tools need to be in path:

- [terraform-lsp](https://github.com/juliosueiras/terraform-lsp)
- fzf
- bufls `go install github.com/bufbuild/buf-language-server/cmd/bufls@latest`
- TODO: append lsp servers

## setup

```
:PackerUpdate
```

## configuration

Well, it's lua configuration already. But you might want to customize [keymaps](./lua/config-keys.lua)
