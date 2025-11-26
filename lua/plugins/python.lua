return {

  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "pyright",
        "ruff",
        "black",
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      formatters_by_ft = {
        python = { "ruff_format", "black" },
      },
    },
  },

  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.python = { "ruff_format", "black" }

      local orig = opts.format_on_save
      opts.format_on_save = function(bufnr)
        local ft = vim.bo[bufnr].filetype
        if ft == "python" then
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
