local autocmd = vim.api.nvim_create_autocmd

autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.opt_local.buflisted = false
    end
})

local new_cmd = vim.api.nvim_create_user_command

new_cmd("SayHi", function()
    print "Hi"
end, {})

new_cmd("EnsureLsp", function()
    local languages = require("canta2899.languages")

    local servers = {}

    for _, value in pairs(languages) do
        if value.lsp then servers[#servers + 1] = value.lsp end
    end

    require("mason-lspconfig").setup({ ensure_installed = servers })
end, {})
