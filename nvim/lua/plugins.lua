-- bootstrap packer
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    vim.cmd [[packadd packer.nvim]]
end

local packer = require("packer")

packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
    }
}


-- Install plugins
packer.startup(function(use)

    local configmap = require("config")

    use 'wbthomason/packer.nvim'
    use { 'lewis6991/impatient.nvim', config = function() require("impatient").enable_profile() end }

    -- Syntax Highlighting
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
        config = configmap["treesitter"]
    }
    use 'fladson/vim-kitty'
    use 'elkowar/yuck.vim'
    use 'gentoo/gentoo-syntax'
    use 'theRealCarneiro/hyprland-vim-syntax'
    use { 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' }
    use { 'lewis6991/spellsitter.nvim', config = configmap["spellsitter"] }

    -- Completion
    use { 'hrsh7th/nvim-cmp', config = configmap["nvim-cmp"] }
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'rafamadriz/friendly-snippets'
    use { 'williamboman/mason.nvim', config = configmap["mason"] }
    use { 'williamboman/mason-lspconfig.nvim', config = configmap["mason-lsp"] }
    use { 'neovim/nvim-lspconfig', config = configmap["lspconfig"] }
    use 'simrat39/rust-tools.nvim'
    use 'folke/neodev.nvim'

    -- Dev Util
    use { 'xuhdev/vim-latex-live-preview', config = configmap["latex-preview"] }
    use {
        'saecki/crates.nvim',
        tag = 'v0.3.0',
        requires = { 'nvim-lua/plenary.nvim' },
        config = function()
            require('crates').setup()
        end,
    }
    use { 'ftilde/vim-ugdb', ft = { 'c', 'cpp', 'rust', 'zig' } }
    use {
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
        ft = { 'markdown' }
    }
    use 'ziglang/zig.vim'
    use { 'RaafatTurki/hex.nvim', config = function() require("hex").setup() end }

    -- Text Manipulation
    use 'tpope/vim-surround'
    use { 'matze/vim-move', config = configmap["vim-move"] }
    use { 'windwp/nvim-autopairs', config = configmap["autopairs"] }
    use 'tpope/vim-commentary'
    use 'rmagatti/alternate-toggler'
    use 'jbyuki/venn.nvim' -- Fancy graphdrawing
    use 'svermeulen/vim-cutlass'

    -- Navigation
    use { 'christoomey/vim-tmux-navigator', config = configmap["vim-tmux"] }
    use {
        'nvim-telescope/telescope.nvim',
        requires = { 'nvim-lua/plenary.nvim' },
        config = configmap["telescope"]
    }
    use('crispgm/telescope-heading.nvim')
    use {
        'folke/todo-comments.nvim',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = configmap["todo-comments"],
    }
    use { 'anuvyklack/hydra.nvim', config = configmap["hydra"] }
    use { 'jghauser/follow-md-links.nvim', ft = { 'markdown' } }
    use {
        'ggandor/leap.nvim',
        config = function()
            require("leap").set_default_keymaps()
        end
    }
    use 'wellle/targets.vim'
    use { 'gbprod/stay-in-place.nvim', config = function() require("stay-in-place").setup {} end }
    use 'derekwyatt/vim-fswitch'

    -- Util
    use 'tpope/vim-repeat'
    use 'jghauser/mkdir.nvim'
    use { 'axieax/urlview.nvim', config = configmap["urlview"] }
    use { 'numToStr/FTerm.nvim', config = configmap["fterm"] }
    use 'moll/vim-bbye'
    use { 'max397574/better-escape.nvim', config = configmap["better-escape"] }
    use 'tpope/vim-vinegar'

    -- Git
    use {
        'lewis6991/gitsigns.nvim',
        requires = {
            'nvim-lua/plenary.nvim'
        },
        config = configmap["gitsigns"],
    }

    -- Aesthetics
    use { 'sainnhe/sonokai', config = function() vim.cmd("colorscheme sonokai") end }
    use { 'nvim-lualine/lualine.nvim', config = configmap["lualine"] }
    use { 'j-hui/fidget.nvim', config = configmap["fidget"] }
    use 'stevearc/dressing.nvim' --better looking vim.ui interfaces
    use { 'h-hg/numbers.nvim', config = function() require("numbers").setup {} end }
    use { 'norcalli/nvim-colorizer.lua', config = configmap["colorizer"] }
    use 'kyazdani42/nvim-web-devicons'
    use 'eandrju/cellular-automaton.nvim'
    use 'tamton-aquib/duck.nvim'
    use { 'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'kyazdani42/nvim-web-devicons',
        config = configmap["bufferline"],
    }

    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end

end)
