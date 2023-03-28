require("mason").setup({
  ui = {
      icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗"
      }
  }
})

-- 语言服务
-- 'sumneko_lua'
-- intelephense
local servers = {'lua_ls', 'clangd', 'gopls', 'pyright', 'tsserver', 'html', 'eslint', 'jsonls', 'vuels', 'cssls', 'lemminx', 'yamlls', 'emmet_ls', 'marksman', 'intelephense'}
require("mason-lspconfig").setup({
  -- 确保安装，根据需要填写
  ensure_installed = {}
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')

-- on_attach 高亮
local on_attach = function(client, bufnr)

    -- Highlight symbol under cursor
    -- 0.7
    -- if client.resolved_capabilities.document_highlight then
    -- 0.8
    if client.server_capabilities.documentHighlightProvider then
    vim.cmd [[
        hi! LspReferenceRead cterm=bold ctermbg=red guibg=Grey
        hi! LspReferenceText cterm=bold ctermbg=red guibg=Grey
        hi! LspReferenceWrite cterm=bold ctermbg=red guibg=Grey
        augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd! CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
        autocmd! CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        autocmd! CursorMovedI <buffer> lua vim.lsp.buf.clear_references()
        augroup END
    ]]
    end

    -- Highlight line number
    vim.cmd [[
    highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
    highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
    highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
    highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

    sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
    sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
    sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
    sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint
    ]]

    -- Show line diagnostics automatically in hover window
    -- vim.api.nvim_create_autocmd("CursorHold", {
    -- buffer = bufnr,
    -- callback = function()
    --     local opts = {
    --     focusable = false,
    --     close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
    --     border = 'rounded',
    --     source = 'always',
    --     prefix = ' ',
    --     scope = 'cursor',
    --     }
    --     vim.diagnostic.open_float(nil, opts)
    -- end
    -- })


    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {border = 'rounded'}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
    )

end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

require('lspconfig').lua_ls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' }
            }
        }
    }
}
