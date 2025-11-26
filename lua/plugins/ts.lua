return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "typescript-language-server",
        "prettier",
        "eslint_d",
      })
    end,
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.javascript = { "prettier" }
      opts.formatters_by_ft.typescript = { "prettier" }
      opts.formatters_by_ft.javascriptreact = { "prettier" }
      opts.formatters_by_ft.typescriptreact = { "prettier" }

      local orig = opts.format_on_save
      opts.format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "typescript" or ft == "javascript" or ft == "typescriptreact" or ft == "javascriptreact" then
          return {
            timeout_ms = 2000,
            lsp_fallback = true,
          }
        end
        if type(orig) == "function" then
          return orig(bufnr)
        end
        return orig
      end

      return opts
    end,
  },
}
