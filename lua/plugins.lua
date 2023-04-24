-- vim.o 常规选项
-- vim.wo 窗口选项
-- vim.bo 缓冲区选项
-- vim.g 全局变量
-- vim.env 环境变量
-- vim.opt 设置全局，窗口，缓冲区
-- vim.fn vim 函数
-- vim.cmd 执行 vimscript 代码

-- 自动安装packer
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()


-- 保存此文件自动更新安装软件
-- 注意PackerCompile改成了PackerSync
-- plugins.lua改成了plugins-setup.lua，适应本地文件名字
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerInstall
  augroup end
]])

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- 缩短启动时间
    use 'lewis6991/impatient.nvim'
    use 'nathom/filetype.nvim'

	-- language
    use {
        "williamboman/mason.nvim",
        'williamboman/mason-lspconfig.nvim',
        'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
    }

    -- 自动完成
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-calc'
    use 'saadparwaiz1/cmp_luasnip' -- luasnip 
    use 'rafamadriz/friendly-snippets' -- 代码片段集合
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'onsails/lspkind-nvim' -- 美化

    -- treesitter
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

    -- 主题
    use 'ellisonleao/gruvbox.nvim'
    use 'folke/tokyonight.nvim'

    -- 状态栏
    use {
        'nvim-lualine/lualine.nvim',
        -- requires = { 'kyazdani42/nvim-web-devicons', opt = true }
        -- 和 file tree 冲突
    }

	-- file tree
	use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        }
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
    }

    -- 颜色
    use ({
        "norcalli/nvim-colorizer.lua",
        config = function()
            require("colorizer").setup({
                "css";
                "html";
                "vue";
                "php";
            })
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
    -- 多次复制
    -- siwp
    use({
        "gbprod/substitute.nvim",
        config = function()
            require("substitute").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
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
                force_write_shada = true,
            })
        end
    })

    -- quickfix
    use {'kevinhwang91/nvim-bqf', ft = 'qf'}

    -- buffer line
    -- use {'akinsho/bufferline.nvim', requires = 'nvim-tree/nvim-web-devicons'}


    -- markdown preview
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    -- image paste
    use 'ekickx/clipboard-image.nvim'


    -- test
    use {
        "klen/nvim-test",
        config = function()
            require('nvim-test').setup()
        end
    }

    -- lsp ui
    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({})
        end,
        requires = {
            {"nvim-tree/nvim-web-devicons"},
            --Please make sure you install markdown and markdown_inline parser
            {"nvim-treesitter/nvim-treesitter"}
        }
    })


    use {
       "ray-x/lsp_signature.nvim",
        config = function()
            require("lsp_signature").setup({})
        end,
    }

    -- todo
    use {
        "folke/todo-comments.nvim",
        requires = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup {}
        end
    }

    -- repeat
    use 'tpope/vim-repeat'

    -- git diff
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }


    -- obsidian
    use "epwalsh/obsidian.nvim" 

    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if packer_bootstrap then
        require('packer').sync()
    end

end)
