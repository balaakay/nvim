local lsp_zero = require('lsp-zero')

-- lsp_attach is where you enable features that only work
-- if there is a language server active in the file
local lsp_attach = function(client, bufnr)
  local opts = {buffer = bufnr}

  vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
  vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
  vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
  vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
  vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
  vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
  vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
end

lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = lsp_attach,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})


-- These are my LSP's
require('lspconfig').cssls.setup({})
require('lspconfig').html.setup({})
require('lspconfig').lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = { globals = { 'vim' } },
    },
  },
})
require('lspconfig').eslint.setup({})
require('lspconfig').ts_ls.setup{}
require('lspconfig').pylsp.setup({
    settings = {
        pylsp = {
            plugins = {
                pylint = {
                    enabled = true,
                    args = { "--disable=invalid-name" }
                },
                --pyflakes = { enabled = true },
                --pycodestyle = { enabled = true },
                jedi = {
                    environment = "/home/Documents/projects/housingMarketResearch/mainVenv/bin/python"
                }
            }
        }
    }
})
require('lspconfig').sqlls.setup({})
require('lspconfig').vuels.setup({})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = {
  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
  ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
  ['<C-Space>'] = cmp.mapping.complete(),
}

  --mapping = cmp.mapping.preset.insert({}),
})

--local bypass_chars = { ';', ',', ']', '}', '\'', '"', '>'}

--local function bypass_if_needed(fallback, char)
--  local line = vim.api.nvim_get_current_line()
--  local cursor_col = vim.api.nvim_win_get_cursor(0)[2] + 1
--  local next_char = line:sub(cursor_col, cursor_col)

--  if next_char == char then
--    vim.api.nvim_win_set_cursor(0, { vim.api.nvim_win_get_cursor(0)[1], cursor_col })
--  else
--    fallback()
--  end
--end

--local bypass_mappings = {}
--for _, char in ipairs(bypass_chars) do
--  bypass_mappings[char] = cmp.mapping(function(fallback)
--    bypass_if_needed(fallback, char)
--  end, { 'i', 's' })
--end

--local custom_mappings = {
--  ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
--  ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
--  ['<C-y>'] = cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Replace }),
--  ['<C-Space>'] = cmp.mapping.complete(),
--}

--local merged_mappings = vim.tbl_extend('force', bypass_mappings, custom_mappings)


