local coverage = require("coverage")
local keys = require("config-keys")
local opts = { noremap = true, silent = true }

coverage.setup({
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

vim.keymap.set('n', keys.Testing.Coverage, function ()
  coverage.load(false)
  coverage.toggle()
end, opts)
