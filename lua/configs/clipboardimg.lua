require'clipboard-image'.setup {
    default = {
        img_dir = {"%:p:h", "attachments"}, -- Use table for nested dir (New feature form PR #20)
        img_dir_txt = "./attachments",
    }
}


