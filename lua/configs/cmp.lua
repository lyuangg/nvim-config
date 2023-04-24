local lspkind = require('lspkind')
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
    preselect = cmp.PreselectMode.None,
    -- 默认选中第一个
    -- completion = {
    --     completeopt = 'menu,menuone,noinsert'
    -- },
    mapping = cmp.mapping.preset.insert({
        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        },
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                local entry = cmp.get_selected_entry()
                if not entry then
                    cmp.select_next_item({behavior = cmp.SelectBehavior.Select})
                end
                cmp.confirm()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.jumpable( -1) then
                luasnip.jump( -1)
            else
                fallback()
            end
        end, { "i", "s" }),

    }),
    sources = cmp.config.sources({
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'nvim_lsp' },
        { name = "buffer" },
        { name = 'path' },
        { name = 'calc' },
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
            before = function(entry, vim_item)
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

cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

-- nvim-cmp for commands
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- 自定义片段
local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

ls.add_snippets("go", {
    s("2006", { t("2006-01-02 15:04:05") })
})
ls.add_snippets("go", {
    s("Y-m-d H:i:s", {
        t("2006-01-02 15:04:05"),
    }),
})

ls.add_snippets("go", {
    s("iferr", {
        t("if err != nil "),
        t({ "{", "\t" }),
        i(1, "return err"),
        t({ "\t", "}" }),
        i(0),
    }),
})

ls.add_snippets("markdown", {
    s("··", {
        t("```"),
        i(1, "go"),
        t({ "\t", "```" })
    }),
    s("···", {
        t("```"),
        i(1, "go"),
        t({ "\t", "```" })
    }),
    s("·", {
        t("`"),
        i(1, ""),
        t({ "`" })
    }),
    s("‘", {
        t("'"),
        i(1, ""),
        t({ "'" })
    }),
    s("“", {
        t('"'),
        i(1, ""),
        t('"'),
    }),
    s("《", {
        t("<"),
    }),
    s("》", {
        t(">"),
    }),
})

local ret_filename = function (args, parent, user_args)
    if user_args == "fname" then
        return vim.fn.expand('%:t:r')
    elseif user_args == "fpath" then
        return vim.fn.expand('%:p')
    elseif user_args == "fdir" then
        return vim.fn.expand('%:p:h')
    else
        return vim.fn.expand('%:t')
    end
end
ls.add_snippets("all", {
    s("fname", {
        f(ret_filename, {}, {user_args={"fname"}})
    })
})
ls.add_snippets("all", {
    s("fpath", {
        f(ret_filename, {}, {user_args={"fpath"}})
    })
})
ls.add_snippets("all", {
    s("fdir", {
        f(ret_filename, {}, {user_args={"fdir"}})
    })
})
ls.add_snippets("all", {
    s("filename", {
        f(ret_filename, {}, {user_args={"filename"}})
    })
})
