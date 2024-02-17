vim.g.mapleader = " "

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Vim for Colemak
map("", "n", "j", {})
map("", "e", "k", {})
map("", "i", "l", {})
map("", "k", "e", {})
map("", "K", "E", {})
--map("", "m", "n", {})
map("", "l", "i", {})
map("", "K", "N", {})
map("", "N", "5j", {})
map("", "E", "5k", {})
map("", "L", "I", {})

map("", "H", "0", {})
map("", "I", "$", {})

-- Shortcut for quiting and saving
map("", "Q", ":q<cr>", {})
map("", "S", ":w<cr>", {})

-- Copy and Past from the system clipboard
map("v", "Y", '"+y', {})
map("n", "P", '"+p', {})

-- Clear last search highlights
map('n', '<esc>', ":noh<return><esc>", {})
map('n', '<esc>^[', "<esc>^[", {})

map('n', '<leader>tv', ':Ex<cr>', {})



