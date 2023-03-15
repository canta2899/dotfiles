local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local lsplanguages = require "custom.configs.lsplanguages"
local servers = {}
local util = require 'lspconfig.util'

for _, value in pairs(lsplanguages) do
    servers[#servers+1] = value.lsp
end


for _, lsp in ipairs(servers) do
  -- exception for deno / javascript to avoid clashing
  -- this should be done better
  if lsp == "denols" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    }
  elseif lsp == "tsserver" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      root_dir = lspconfig.util.root_pattern("package.json")
    }
  elseif lsp == "hls" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      single_file_support = true,
    }
  else
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end
