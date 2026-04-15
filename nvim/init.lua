vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.smartindent = true
vim.o.shiftwidth = 4
vim.o.wrap = false
vim.o.expandtab = true
vim.o.swapfile = false
vim.g.mapleader = " "

vim.keymap.set('n', '<leader>o', ':update<CR> :source<CR>')
vim.keymap.set('n', '<leader>w', ':write<CR>')
vim.keymap.set('n', '<leader>q', ':quit<CR>')
vim.keymap.set('n', '<leader>e', ':e .<CR>')
vim.keymap.set('n', '<leader>f', ':Pick files<CR>')

--Cosmetics
vim.pack.add({
    --Themes
    { src = "https://github.com/bluz71/vim-nightfly-colors" },
    { src = "https://github.com/catppuccin/nvim"},
    { src ="https://github.com/folke/tokyonight.nvim"},
    { src = "https://github.com/tribela/transparent.nvim"},
    { src = "https://github.com/norcalli/nvim-colorizer.lua"},
    --Plugins
    { src = "https://github.com/nvim-lualine/lualine.nvim"},
    { src = 'https://github.com/nvim-tree/nvim-web-devicons' }, -- optioinal
    { src = 'https://github.com/nvim-tree/nvim-tree.lua' },
    { src = "https://github.com/neovim/nvim-lspconfig" },
    { src = "https://github.com/L3MON4D3/LuaSnip"},
    { src = "https://github.com/rafamadriz/friendly-snippets"},
    { src = "https://github.com/saghen/blink.cmp"},
    { src = "https://github.com/mfussenegger/nvim-jdtls"},
    { src = "https://github.com/nvim-mini/mini.pick"},
    { src = "https://github.com/stevearc/oil.nvim"},
    { src = "https://github.com/elmcgill/springboot-nvim"},
})

vim.cmd("colorscheme catppuccin")

vim.lsp.enable({
                'lua_ls',
                'jdtls',
                'clangd',
                'pyright',
                'gopls',
                'ts_ls',
                'jsonls',
                'kotlin-language-server',
            })

vim.cmd("set completeopt+=noselect")

local springboot_nvim = require("springboot-nvim")
-- SPRING BOOT KEYMAPS 
vim.keymap.set('n', '<leader>Jr', springboot_nvim.boot_run, {desc = "Spring Boot Run Project"})
vim.keymap.set('n', '<leader>Jc', springboot_nvim.generate_class, {desc = "Java Create Class"})
vim.keymap.set('n', '<leader>Ji', springboot_nvim.generate_interface, {desc = "Java Create Interface"})
vim.keymap.set('n', '<leader>Je', springboot_nvim.generate_enum, {desc = "Java Create Enum"})

springboot_nvim.setup({})

require('mini.pick').setup()
-- require('Oil').setup()
--ENABLE TRANSPARENCY
require('transparent').setup()

-- lualine bar
require('lualine').setup()

-- 
require'luasnip.loaders.from_vscode'.load{ exclude = {},}

require("blink.cmp").setup({
    fuzzy = { implementation = "lua" },
    signature = { enabled = true },
    completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 250 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})


-- Display diagnostics on same line
vim.diagnostic.config({
    underline = true,
    virtual_text = {
        spacing = 2,
        prefix = "●",
    },
    update_in_insert = false,
    severity_sort = true,
    signs = {
        text = {
            -- Alas nerdfont icons don't render properly on Medium!
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN] = " ",
            [vim.diagnostic.severity.HINT] = " ",
            [vim.diagnostic.severity.INFO] = " ",
        },
    },
})



-- TREE STUFF
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- color hex highlighting
require('colorizer').setup()

---@type nvim_tree.config
local config = {
    actions = {
        open_file = {
            quit_on_open = true,
        },
    },
    sort = {
      sorter = "case_sensitive",
    },
    view = {
      width = 30,
    },
    renderer = {
      group_empty = true,
    },
    filters = {
      dotfiles = true,
    },
}

require("nvim-tree").setup(config)
