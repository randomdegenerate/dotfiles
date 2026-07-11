vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':e .<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')


-- terminal keymap
vim.keymap.set('n', '<leader>st', function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 10)
end)


vim.keymap.set('n', '<leader>bf', function()
  vim.lsp.buf.format()
end);
