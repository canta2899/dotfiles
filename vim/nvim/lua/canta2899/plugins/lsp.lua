local languages = require("canta2899.languages")
local servers = {}
for _, value in pairs(languages) do
    if value.lsp then servers[#servers + 1] = value.lsp end
end

return {
    {
        'VonHeikemen/lsp-zero.nvim',

        branch = 'v2.x',

        dependencies = {
            -- LSP Support
            { 'neovim/nvim-lspconfig' }, -- Required
            {                            -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end,
            },
            { 'williamboman/mason-lspconfig.nvim' },
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },     -- Required
            { 'hrsh7th/cmp-nvim-lsp' }, -- Required
            { 'L3MON4D3/LuaSnip' },     -- Required
        },

        config = function()
            local lsp = require('lsp-zero').preset({})

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero").cmp_action()

            cmp.setup({
                mapping = {
                    ['<CR>'] = cmp.mapping.confirm({ select = false }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                }
            })


            lsp.preset("recommended")
            lsp.setup()
        end,
    },
}
