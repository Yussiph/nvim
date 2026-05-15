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
-- vim.opt.listchars = { tab = '| ', trail = '·', nbsp = '␣' }
vim.opt.wrap = false


-- PLUGINS --
vim.pack.add({
	'https://github.com/catppuccin/nvim',
	'https://github.com/nvim-treesitter/nvim-treesitter',
	'https://github.com/tpope/vim-sleuth',
	'https://github.com/echasnovski/mini.pairs',
	'https://github.com/echasnovski/mini.comment',
	'https://github.com/nvim-mini/mini.surround',
	'https://github.com/nvim-mini/mini.pick',
	'https://github.com/nvim-mini/mini.files',
	'https://github.com/echasnovski/mini.indentscope',
	'https://github.com/echasnovski/mini.diff',
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
	},
})

require('catppuccin').setup({
	flavour = "mocha",
	transparent_background = true,
})

vim.cmd.colorscheme 'catppuccin'

-- Stop auto-commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		vim.opt.formatoptions:remove({ "c", "r", "o" })
	end,
})




