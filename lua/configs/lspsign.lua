require("lsp_signature").setup{
    bind = false,
    hint_enable = false,
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "rounded"   -- double, rounded, single, shadow, none, or a table of borders
    },
}
