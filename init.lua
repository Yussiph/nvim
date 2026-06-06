vim.g.mapleader = ' '
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.fillchars = { eob = " " }
vim.opt.laststatus = 3
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.smartindent = true
vim.opt.list = true
vim.opt.clipboard = 'unnamedplus'
-- vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
vim.opt.wrap = false

local prefix = 'https://github.com/'

-- PLUGINS --
vim.pack.add({
	prefix .. 'nvim-treesitter/nvim-treesitter',
	prefix .. 'tpope/vim-sleuth',
	prefix .. 'echasnovski/mini.pairs',
	prefix .. 'echasnovski/mini.comment',
	prefix .. 'nvim-mini/mini.surround',
	prefix .. 'nvim-mini/mini.pick',
	prefix .. 'nvim-mini/mini.files',
	prefix .. 'echasnovski/mini.indentscope',
	prefix .. 'echasnovski/mini.diff',
	prefix .. 'echasnovski/mini.statusline',
	prefix .. 'echasnovski/mini.cursorword',
	prefix .. 'echasnovski/mini.icons',
	prefix .. 'folke/tokyonight.nvim',
})

require('mini.pairs').setup({})

require('mini.comment').setup({})
-- gc - gcc

require('mini.surround').setup({})
-- sa - sd - sr

require('mini.pick').setup({})
vim.keymap.set('n', '<leader>f',  '<cmd>Pick files<CR>',   { desc = 'Find Files' })
vim.keymap.set('n', '<leader>b',  '<cmd>Pick buffers<CR>', { desc = 'Find Open Buffers' })
-- Tab to preview selected file
vim.keymap.set('n', '<leader>s',  '<cmd>Pick grep<CR>',    { desc = 'Search Text Inside Files' })
vim.keymap.set('n', '<leader>h',  '<cmd>Pick help<CR>',    { desc = 'Search Help Tags' })

require('mini.files').setup({})
vim.keymap.set('n', '<leader>e', function()
	if not MiniFiles.close() then MiniFiles.open(vim.api.nvim_buf_get_name(0)) end
end, { desc = 'Toggle File explorer' })

require('mini.indentscope').setup({
	symbol = '│',
})

require('mini.diff').setup({
	view = {
		style = 'sign',
		signs = { add = '+', change = '~', delete = '-'},
	},
})

require('mini.statusline').setup({
	set_vim_settings = true,
})

require('mini.cursorword').setup({})

require('mini.icons').setup({
	style = 'glyph',
})
MiniIcons.mock_nvim_web_devicons()




-- Stop auto-commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})


-- == Flutter Setup ==
-- Fetch the official LSP configuration and Flutter tools ecosystem cleanly using vim.pack
vim.pack.add({
  prefix .. 'neovim/nvim-lspconfig',
  prefix .. 'nvim-lua/plenary.nvim',
  prefix .. 'nvim-flutter/flutter-tools.nvim',
  prefix .. 'saghen/blink.cmp', -- Add the completion engine
})

require("flutter-tools").setup({
  fvm = true,
})

-- Set up Flutter tools (it automatically sets up dartls behind the scenes)
-- require('flutter-tools').setup({
--   ui = {
--     border = 'rounded', -- Clean rounded panels for floating documentation
--   },
--   decorations = {
--     statusline = {
--       device = true,    -- Shows your current active mobile device/emulator in your statusline
--       app_version = true,
--     }
--   },
--   lsp = {
--     -- The deprecated color configuration has been removed from here!
--
--     -- Attach our global keyboard-centric keymaps and settings when the server connects
--     on_attach = function(client, bufnr)
--       local opts = { buffer = bufnr, silent = true }
--
--       -- Enable modern native Neovim color highlights for Flutter colors/icons
--       if vim.lsp.document_color and vim.lsp.document_color.enable then
--         vim.lsp.document_color.enable(true, { bufnr = bufnr })
--       end
--
--       -- Keymaps for navigating and auditing code structures
--       vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)      -- Go to definition
--       vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)            -- Show documentation overview
--       vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts) -- Code actions
--       vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)   -- Rename symbol across project
--     end,
--   }
-- })


-- Configure Blink for automated neon-vivid popup listings
require('blink.cmp').setup({
  keymap = {
    preset = 'default', -- Sets up Up/Down arrows or Ctrl-n/Ctrl-p out of the box
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' }, -- Enter key accepts the suggestion
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
})

 -- Themes --
vim.pack.add({
	prefix .. '54L1M/Oshen.nvim',
	"https://gitlab.com/motaz-shokry/gruvbox.nvim",
})

require("oshen").setup({
  transparent = true,
})


require("gruvbox").setup({
  variant = "auto",

  styles = {
    bold = true,
    italic = true,
    transparency = true,
  },
})

require("tokyonight").setup({
	style = 'moon',
	transparent = true,
	styles = {
		sidebars = transparent,
		floats = transparent,
	},
	on_colors = function(colors)
		colors.git.add = '#44dfaa'
		colors.git.change = '#3daee9'
		colors.git.delete = '#ff5370'
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
	end,
})


-- This is only used for some themes
-- vim.api.nvim_create_autocmd("ColorScheme", {
--   pattern = "*", -- Applies to any theme, or replace with your specific theme name
--   callback = function()
--     vim.api.nvim_set_hl(0, "@string", { fg = "#888888"})
--     vim.api.nvim_set_hl(0, "String", { fg = "#888888"})
--   end,
-- })

vim.cmd[[colorscheme tokyonight]]

local colors = {
  'Normal', 'NormalFloat', 'SignColumn', 'LineNr', 
  'FoldColumn', 'StatusLine', 'StatusLineNC', 'WinSeparator'
}

for _, group in ipairs(colors) do
  vim.api.nvim_set_hl(0, group, { bg = 'NONE', ctermbg = 'NONE' })
end


vim.api.nvim_set_hl(0, "MiniCursorword", { 
  underline = true, 
  bg = "NONE" 
})

vim.api.nvim_set_hl(0, "MiniCursorwordCurrent", { 
  underline = true, 
  bg = "NONE" 
})

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch', -- Uses your theme's vibrant search highlight color
      timeout = 150,         -- How long the flash lasts in milliseconds
    })
  end,
})

-- Clear search highlights on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlights' })
