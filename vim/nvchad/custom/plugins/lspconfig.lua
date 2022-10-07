local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lsplanguages = require "custom.plugins.lsplanguages"
local servers = {}

for _, value in pairs(lsplanguages) do
    servers[#servers+1] = value.lsp
end


for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
