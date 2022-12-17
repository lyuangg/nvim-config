-- 安装lsp
require("nvim-lsp-installer").setup {
  automatic_installation = true
}

-- 自动完成
-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')


-- on_attach 高亮
local on_attach = function(client, bufnr)
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
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
     }, {
      { name = 'buffer'},
      { name = 'path' },
    })
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



