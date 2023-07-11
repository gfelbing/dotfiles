local coverage = require("coverage")
local keys = require("config-keys")
local opts = { noremap = true, silent = true }

vim.keymap.set('n', keys.Testing.Coverage, function ()
  coverage.load(false)
  coverage.toggle()
end, opts)
