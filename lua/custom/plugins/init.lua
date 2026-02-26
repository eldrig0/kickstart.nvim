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
          enabled = false,
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

  {
    'pmizio/typescript-tools.nvim',
    dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
    config = function()
      local aug = vim.api.nvim_create_augroup('FormatOnSave', {})

      require('typescript-tools').setup {
        on_attach = function(_, bufnr)
          vim.api.nvim_clear_autocmds { group = aug, buffer = bufnr }

          vim.api.nvim_create_autocmd('BufWritePre', {
            group = aug,
            buffer = bufnr,
            callback = function(ev)
              vim.cmd 'TSToolsFixAll sync'
              vim.lsp.buf.format { async = false }
            end,
          })

          vim.keymap.set('n', '<leader>fw', function()
            vim.cmd 'TSToolsFixAll sync'
            vim.lsp.buf.format { async = false }
            vim.cmd 'write'
          end, { buffer = bufnr, desc = 'TS Fix + Format + Write' })
        end,
      }
    end,
    settings = {
      insertSpaceAfterCommaDelimiter = true,
      insertSpaceAfterConstructor = true,
      insertSpaceAfterSemicolonInForStatements = true,
      insertSpaceBeforeAndAfterBinaryOperators = true,
      insertSpaceAfterKeywordsInControlFlowStatements = true,
      insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
      insertSpaceBeforeFunctionParenthesis = false,

      insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = true,
      insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = true,
      insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
      insertSpaceAfterTypeAssertion = false,
      placeOpenBraceOnNewLineForFunctions = true,
      placeOpenBraceOnNewLineForControlBlocks = false,
      semicolons = 'ignore',
      indentSwitchCase = true,
    },
  },
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = function()
      vim.fn['mkdp#util#install']()
    end,
  },
}
