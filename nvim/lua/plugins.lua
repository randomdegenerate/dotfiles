vim.pack.add({
    { src = "https://github.com/mplusp/pack-manager.nvim"},
    { src = "https://github.com/catppuccin/nvim"},
    { src = "https://github.com/blazkowolf/gruber-darker.nvim"},
    { src = "https://github.com/bluz71/vim-moonfly-colors"},
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim"},
    { src = "https://github.com/norcalli/nvim-colorizer.lua"},
    { src = "https://github.com/nvim-lualine/lualine.nvim"},
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/L3MON4D3/LuaSnip"},
    { src = "https://github.com/rafamadriz/friendly-snippets"},
    { src = "https://github.com/saghen/blink.cmp"},
    { src = "https://github.com/mfussenegger/nvim-jdtls"},
    { src = "https://github.com/nvim-mini/mini.pick"},
    { src = "https://github.com/stevearc/oil.nvim"},
    { src = "https://github.com/ThePrimeagen/refactoring.nvim"},
    { src = "https://github.com/norcalli/nvim-colorizer.lua"},
})

-- THEMES
-- catppuccin-macchiato/mocha
-- nightfly 
vim.cmd("colorscheme oxocarbon")

require('mini.pick').setup()
-- vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })

require('lualine').setup {
  options = { theme = 'palenight'}
}

require('colorizer').setup()

require('luasnip.loaders.from_vscode').load{ exclude = {},}

require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
    completion = {
        menu = {
            auto_show = false,
        },
        documentation = {
            auto_show = false,
            auto_show_delay_ms = 250,
        },
    },
    sources = { default = { "lsp" } },
})

require('oil').setup()
--require('nvim-tree').setup({
--      sort = {
--        sorter = "case_sensitive",
--      },
--
--      view = {
--        width = 25,
--      },
--
--      renderer = {
--        group_empty = true,
--      },
--
--      filters = {
--        dotfiles = true,
--      },
--})






