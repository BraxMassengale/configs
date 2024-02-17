local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

local opts = {
  sources = {
    null_ls.builtins.formatting.prettierd,
  },
  on_attach = function (client, bufrn)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({
        group = augroup,
        buffer = bufrn,
      })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufrn,
        callback = function ()
          vim.lsp.buf.format({ bufrn = bufrn })
        end,
      })
    end
  end
}

return opts
