vim.lsp.enable({
    'lua_ls',
    'clangd',
    'pyright',
    'ts_ls',
    'gopls',
    'jdtls',
    'kotlin_lsp',
    'jsonls',
    'yamlls',
})

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
