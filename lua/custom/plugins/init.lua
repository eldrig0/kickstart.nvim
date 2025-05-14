-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {
        debugger = {
          enabled = true,
        },
        fvm = true,
        widget_guides = {
          enabled = true,
        },
        lsp = {
          on_attach = function(_, bufnr)
            -- Enable format on save
            vim.api.nvim_create_autocmd('BufWritePre', {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format {
                  async = false,
                  timeout_ms = 5000,
                }
              end,
            })

            -- Add format and save keybinding
            vim.keymap.set('n', '<leader>fw', function()
              vim.lsp.buf.format { async = false }
              vim.cmd 'write'
            end, { buffer = bufnr, desc = 'Format and save' })
          end,
          settings = {
            lineLength = 80,
          },
        },
      }
    end,
  },
}
