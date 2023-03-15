local present, null_ls = pcall(require, "null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/548
--
if not present then
  return
end

local sources = {
  null_ls.builtins.formatting.prettier,
  null_ls.builtins.formatting.markdownlint,
  null_ls.builtins.formatting.gofmt
}

null_ls.setup {
  debug = true,
  sources = sources,
}
