-- Hashmap of themes with { git_repo, theme_name, custom_options }
local themes = {
  ['catppuccin'] = { 'catppuccin/nvim', 'catppuccin', { background = { dark = 'mocha' } } },
  ['gruvbox'] = { 'morhetz/gruvbox', 'gruvbox', {} },
  ['noctis'] = { 'talha-akram/noctis.nvim', 'noctis', {} },
  ['tokyodark'] = { 'tiagovla/tokyodark.nvim', 'tokyodark', {} },
  ['awesome'] = { 'rafi/awesome-vim-colorschemes', 'deus', {} },
  ['andromeda'] = { 'safv12/andromeda.vim', 'andromeda', {} },
  ['modest'] = { 'matveyt/vim-modest', 'modest', {} },
  ['incorrectish'] = { 'incorrectish/incorrectish_colors', 'incorrectish_colors', {} },
}

-- Set the active theme here, only this will be loaded
local active_theme = 'awesome'

return {
  {
    themes[active_theme][1],
    lazy = false,
    priority = 1000,
    opts = themes[active_theme][3],
    config = function ()
      vim.cmd { cmd = 'colorscheme', args = { themes[active_theme][2] } }
    end
  }
}
