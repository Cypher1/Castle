-- This file can be loaded by calling `lua require('plugins')` from your init.vim

return require('packer').startup(function(use)
	-- Packer can manage itself
	use 'wbthomason/packer.nvim'

	use {
		'nvim-telescope/telescope.nvim', tag = '0.1.6',
		-- or                            , branch = '0.1.x',
		requires = { {'nvim-lua/plenary.nvim'} }
	}

	use {
		'ratazzi/blackboard.vim',
		config = function()
			vim.cmd('colorscheme blackboard')
		end
	}
	use {
		'rose-pine/neovim',
		as = 'rose-pine',
	}
	use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

	use('theprimeagen/harpoon')
	use('mbbill/undotree')
	use('tpope/vim-fugitive')

	-- use('junegunn/fzf', { dir = '~/.fzf', run = './install --all' }
	-- use('junegunn/fzf.vim')

	-- Tweaks & Fixes
	use('ConradIrwin/vim-bracketed-paste')  -- Paste properly
	use('tpope/vim-repeat')                 -- Repetitions
	use('roxma/vim-window-resize-easy')     -- Resize windows
	use('tmhedberg/matchit')                -- % Match based jumping
	use('tpope/vim-eunuch')                 -- Unix built in
	-- Tools
	use('AndrewRadev/switch.vim')           -- Switch t->f
	use('nvim-tree/nvim-tree.lua')          -- File manager
	use('mhinz/vim-signify')                -- Sign column diffs
	use('ap/vim-css-color')                 -- Show Colors in CSS
	use('google/vim-searchindex')           -- Count search solutions
	-- use('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } -- Async completion

	-- Format / Language Specifics
	use('chrisbra/csv.vim')                -- CSV
	use('sbdchd/neoformat')                -- Autoformat (includes clang-format)

	-- LSP stuff
	use('neovim/nvim-lspconfig')
	use('williamboman/mason.nvim')
	use('williamboman/mason-lspconfig.nvim')
	use('hrsh7th/nvim-cmp')
	use('hrsh7th/cmp-nvim-lsp')
	use('hrsh7th/cmp-buffer')
	use('hrsh7th/cmp-path')
	use('saadparwaiz1/cmp_luasnip')
	use('L3MON4D3/LuaSnip')
	use('rafamadriz/friendly-snippets')
end)
