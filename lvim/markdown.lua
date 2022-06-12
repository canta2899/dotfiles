-- Should be placed in after/ftplugin/markdown.lua
-- Disables spell because i read what i write
vim.cmd("setlocal nospell")

-- Disables buffer as source preserving other sources
local cmp = require('cmp')
local sources = cmp.get_config().sources
for i = #sources, 1, -1 do
  if sources[i].name == 'buffer' then
    table.remove(sources, i)
  end
end
cmp.setup.buffer({ sources = sources })

-- disables buffer (but also snippets)
-- require('cmp').setup.buffer { enabled = false }
