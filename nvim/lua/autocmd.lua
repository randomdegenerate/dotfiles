vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("lsp", { clear = true }),
    callback = function(args)
        -- 2
        vim.api.nvim_create_autocmd("BufWritePre", {
            -- 3
            buffer = args.buf,
            callback = function()
                -- 4 + 5
                vim.lsp.buf.format { async = false, id = args.data.client_id }
            end,
        })
    end
})

vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('custom-term-open', { clear = true }),
    callback = function()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
})
