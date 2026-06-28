vim.pack.add({
  { src = "https://github.com/mplusp/pack-manager.nvim" },
  --
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
  { src = "https://github.com/bluz71/vim-moonfly-colors" },
  { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },
  { src = "https://github.com/metalelf0/black-metal-theme-neovim" },
  --
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/saghen/blink.cmp",                  version = vim.version.range('*'), "https://github.com/saghen/blink.lib" },
  { src = "https://github.com/mfussenegger/nvim-jdtls" },
  { src = "https://github.com/folke/lazydev.nvim" },
  --
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = "https://github.com/nvim-mini/mini.pick" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/ThePrimeagen/refactoring.nvim" },
  { src = "https://github.com/lewis6991/async.nvim" },
  { src = "https://github.com/norcalli/nvim-colorizer.lua" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/xiyaowong/transparent.nvim"},
})

-- THEMES
-- catppuccin-macchiato/mocha
-- nightfly
vim.cmd("colorscheme catppuccin-mocha")
require('transparent').setup({})
require('mini.pick').setup()
require('lualine').setup {
  options = { theme = 'palenight' }
}
require('oil').setup()
--require('colorizer').setup()
require('luasnip.loaders.from_vscode').load { exclude = {}, }
require('blink.cmp').setup({
  fuzzy = { implementation = "prefer_rust_with_warning" },
  completion = {
    keyword = { range = 'full' },
    list = {
      selection = {
        preselect = true,
        auto_insert = false,
      }
    },
    menu = {
      auto_show = false,
      draw = {
        columns = {
          { "label",     "label_description", gap = 1 },
          { "kind_icon", "kind" }
        },
      },
    },
    documentation = { auto_show = false, auto_show_delay_ms = 500 },
    ghost_text = {
      enabled = false,
    },
  },
  sources = { default = { "lsp", "path", "snippets" } },
  snippets = { preset = 'luasnip' },
  signature = { enabled = true },
})
