local keys = require("config-keys")

vim.api.nvim_set_keymap("n", keys.Git.Lazy, ':LazyGit<CR>', { noremap = true, silent = true })

function toggleBlame ()
  if (vim.bo.filetype == 'fugitiveblame') then
    vim.cmd('close')
  else
    vim.cmd('Git blame')
  end
end

vim.keymap.set("n", keys.Git.Blame, toggleBlame, { noremap = true, silent = true })
