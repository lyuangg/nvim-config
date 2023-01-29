-- 安装lsp
require("nvim-lsp-installer").setup {
  automatic_installation = true
}

-- 自动完成
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

local lspkind = require('lspkind')

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
    vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    callback = function()
        local opts = {
        focusable = false,
        close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
        border = 'rounded',
        source = 'always',
        prefix = ' ',
        scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
    })


    vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(
        vim.lsp.handlers.hover,
        {border = 'rounded'}
    )

    vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers.signature_help,
        {border = 'rounded'}
    )

end

-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
local servers = { 'clangd', 'gopls', 'pyright', 'tsserver', 'html', 'intelephense', 'eslint', 'jsonls', 'vuels', 'cssls', 'lemminx', 'yamlls', 'emmet_ls'} -- 语言服务
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- luasnip setup
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local luasnip = require 'luasnip'

-- 加载代码片段 friendly-snippets
require("luasnip.loaders.from_vscode").lazy_load()

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
     ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        else
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            cmp.confirm()
        end
        -- local entry = cmp.get_selected_entry()
        -- if not entry then
        --     if luasnip.expand_or_jumpable() then
        --         luasnip.expand_or_jump()
        --     else
        --         cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
        --         cmp.confirm()
        --     end
        -- else
        --     cmp.confirm()
        -- end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),

  }),
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = "buffer" },
      { name = 'path' },
      { name = 'calc' },
      -- { name = 'emoji' },
  }),
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol_text', -- show only symbol annotations
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
      ellipsis_char = '...', -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function (entry, vim_item)
          -- fancy icons and a name of kind
        vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
        -- set a name for each source
        vim_item.menu =
            ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
            ultisnips = "[UltiSnips]",
            nvim_lua = "[Lua]",
            cmp_tabnine = "[TabNine]",
            look = "[Look]",
            path = "[Path]",
            spell = "[Spell]",
            calc = "[Calc]",
            emoji = "[Emoji]"
        })[entry.source.name]
        return vim_item
      end
    })
  }
}

-- nvim-autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

-- nvim-cmp for commands
cmp.setup.cmdline(':', {
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- 自定义片段
local ls = require"luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
ls.add_snippets("go", {
	s("2006", { t("2006-01-02 15:04:05") })
})

ls.add_snippets("go", {
    s("iferr", {
		t("if err != nil "),
        t({ "{", "\t" }),
		i(1, "return err"),
        t({"\t", "}"}),
		i(0),
	}),

})



