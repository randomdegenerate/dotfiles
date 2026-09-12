-- looks for list of lsp names in variable and formats and enables the lsp-config
-- configuration allowing for the shell itself to decide what lsp's are active
-- therefore meaning i define the active lsp configurations and provide the required
-- package to use any lsp within in a nix shell
local lsp_servers = vim.env.NVIM_LSP_SERVERS

if lsp_servers then
    for server in string.gmatch(lsp_servers, "[^,]+") do
        vim.lsp.enable(server)
    end
end

-- lsp "required" to live
vim.lsp.enable({"lua_ls","nixd"})

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


vim.lsp.config("astro", {
    init_options = {
        typescript = {
            tsdk = vim.env.TSSDK,
        },
    },
})
