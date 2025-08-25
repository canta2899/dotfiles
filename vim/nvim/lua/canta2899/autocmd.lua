local autocmd = vim.api.nvim_create_autocmd
local new_cmd = vim.api.nvim_create_user_command

autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end,
})


autocmd("LspAttach", {
    callback = function(a)
        local c = vim.lsp.get_client_by_id(a.data.client_id)
        if c and c.name == "ts_ls" and (vim.fn.filereadable("deno.json") == 1 or vim.fn.filereadable("deno.jsonc") == 1) then
            vim.schedule(function() vim.lsp.stop_client(c.id) end)
        end
    end,
})

autocmd("FileType", {
    pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
    callback = function()
        vim.opt_local.shiftwidth = 2
        vim.opt_local.tabstop = 2
    end,
})
