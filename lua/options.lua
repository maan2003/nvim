local opts = {
   completeopt = 'menuone,noselect',
   virtualedit = 'onemore',
   mouse = 'a',
   guifont = 'Agave Nerd Font Mono:h13',
   undofile = true,
   lazyredraw = true,
   expandtab = true,
   softtabstop = 4,
   tabstop = 4,
   shiftwidth = 4,
   hidden = true,
   clipboard = 'unnamed',
   shell = 'zsh',
   lazyredraw = true,
   incsearch = true,
   scrolloff = 3,
}

for key, value in pairs(opts) do
   vim.o[key] = value
end

local wo = vim.wo
wo.wrap = false
wo.number = false
wo.relativenumber = true

