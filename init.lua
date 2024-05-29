
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.cursorline = false

vim.opt.scrolloff = 0
vim.opt.completeopt = {"menu", "menuone", "noselect"}

vim.g.mapleader = ","

-- Install Lazy package manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins

local lazy = require("lazy")
lazy.setup({
  -- LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp' ,
  'hrsh7th/cmp-nvim-lsp',
  'nvim-lua/plenary.nvim',
  -- Search
  'nvim-pack/nvim-spectre',
  -- File explorer
  {
    'nvim-neo-tree/neo-tree.nvim', 
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },
  -- Git
  'sindrets/diffview.nvim',
  -- Color schemes
  'blazkowolf/gruber-darker.nvim',

  -- Other
  'nvim-treesitter/nvim-treesitter',
  'nativerv/cyrillic.nvim',
  'numToStr/Comment.nvim',
  { 'wakatime/vim-wakatime', lazy = false },
  'windwp/nvim-autopairs',

})

vim.cmd.colorscheme( "gruber-darker" )

require("nvim-treesitter.configs").setup({

})


require("cyrillic").setup()
require("mason").setup()
require("nvim-autopairs").setup()
require("mason-lspconfig").setup()
require("Comment").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("mason-lspconfig").setup_handlers {
  function(server_name)
    
  require("lspconfig")[server_name].setup({
    capabilities = capabilities,
  })
  end
}


local cmp = require("cmp")

cmp.setup({
  -- snippet = {
  --   expand = function(args)
  --     
  --   end
  -- },
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
  mapping = cmp.mapping.preset.insert({
    ['j'] = cmp.mapping.select_next_item(),
    ['k'] = cmp.mapping.select_prev_item(),
    ['<ESC>'] = cmp.mapping.abort(),
    ['<TAB>'] = cmp.mapping.confirm({ select = true }),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  })
})

vim.keymap.set({"n", "i"}, "<leader>s", ':Neotree close<CR><cmd> lua require("spectre").toggle()<CR>' )
vim.keymap.set({"n", "i"}, "<leader>e", '<cmd> lua require("spectre").close()<CR>:Neotree toggle<CR>' )
vim.keymap.set({"n", "i"}, "<leader>go", ':DiffviewClose<CR>:DiffviewOpen<CR>' )
vim.keymap.set({"n", "i"}, "<leader>gc", ':DiffviewClose<CR>' )

