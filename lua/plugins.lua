-- vim.o 常规选项
-- vim.wo 窗口选项
-- vim.bo 缓冲区选项
-- vim.g 全局变量
-- vim.env 环境变量
-- vim.opt 设置全局，窗口，缓冲区
-- vim.fn vim 函数
-- vim.cmd 执行 vimscript 代码

vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- 缩短启动时间
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

	-- language
    use 'williamboman/nvim-lsp-installer' -- 语言服务安装
	use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client

    -- 自动完成
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
    use 'saadparwaiz1/cmp_luasnip' -- luasnip 
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'rafamadriz/friendly-snippets' -- 代码片段集合
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- treesitter
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

    -- 主题
    use 'ellisonleao/gruvbox.nvim' 


    -- 状态栏
    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
    -- buffer
    use {
        'akinsho/bufferline.nvim',
        requires = 'kyazdani42/nvim-web-devicons'
    }

	-- file tree
	use {
		'kyazdani42/nvim-tree.lua',
		requires = 'kyazdani42/nvim-web-devicons'
	}

	-- outline
    use 'stevearc/aerial.nvim'

	-- file telescope
	use {
		'nvim-telescope/telescope.nvim',
		requires = 'nvim-lua/plenary.nvim'
	}

    -- startify
    use 'mhinz/vim-startify'

    -- 注释
    use 'terrortylor/nvim-comment'

    -- auto-pairs
    use {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    -- git
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release',
    }

    -- 颜色
    use ({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({})
        end
    })

    -- tmux 快捷键
    use({
        "aserowy/tmux.nvim",
        config = function()
            require("tmux").setup({
                copy_sync = {
                    enable = false,
                },
                navigation = {
                    enable_default_keybindings = true,
                },
                resize = {
                    enable_default_keybindings = false,
                }
            })
        end
    })

    -- surround
    -- delete: ds'
    -- add: ysaw'
    -- update: cs'"
    use({
        "kylechui/nvim-surround",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    })

    -- substitute
    use({
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
            -- your configuration comes here
            })
        end
    })

    -- 标签匹配
    use 'andymass/vim-matchup'


    -- Indent Blankline
    use "lukas-reineke/indent-blankline.nvim"

    -- marks
    use({
        "chentoast/marks.nvim",
        config = function()
            require("marks").setup({
            })
        end
    })

end)
