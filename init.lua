
-- Neovim settings
vim.opt.number = true
vim.opt.mouse = 'a'
vim.opt.cursorline = false

vim.opt.scrolloff = 5
vim.opt.completeopt = {"menu", "menuone", "noselect"}



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
--
local lazy = require("lazy")
lazy.setup({
  'nativerv/cyrillic.nvim',
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  'hrsh7th/nvim-cmp' ,
  'hrsh7th/cmp-nvim-lsp',
  'windwp/nvim-autopairs',
  'nvim-lua/plenary.nvim',
  'nvim-pack/nvim-spectre',
  {
    'nvim-neo-tree/neo-tree.nvim', 
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
  },
  -- Color schemes
  "blazkowolf/gruber-darker.nvim"

})

vim.cmd.colorscheme( "gruber-darker" )


require("cyrillic").setup()
require("mason").setup()
require("nvim-autopairs").setup()
require("mason-lspconfig").setup()

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig")["tsserver"].setup({
  capabilities = capabilities,
})

local cmp = require("cmp")

cmp.setup({
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
