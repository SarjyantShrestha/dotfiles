--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.winborder = 'single'
vim.o.textwidth = 80

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.wrap = false
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.laststatus = 3
vim.o.termguicolors = true
-- vim.opt.winborder = 'single'
-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

vim.opt.swapfile = false

-- Sync clipboard between OS and Neovim.
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.keymap.set('n', 'p', '"0p', { noremap = true, silent = true })
vim.keymap.set('n', 'P', '"0P', { noremap = true, silent = true })

-- Open terminal in horizontal split with a height of 20 lines
vim.api.nvim_set_keymap('n', '<leader>t', ':split | terminal<CR>:resize 10<CR>', { noremap = true, silent = true })

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how neovim will display certain whitespace in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

--remove cursorline color, required for hl-CursorLineNr with cursorline true.
vim.opt.cursorlineopt = { 'number' }

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 5

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Move line up or down after highlight
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Diagnostic keymaps
vim.keymap.set('n', '<leader>qf', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
vim.keymap.set('n', '<leader>of', vim.diagnostic.open_float, { desc = 'Show diagnostic float' })
vim.keymap.set('n', 'K', function()
  vim.lsp.buf.hover {
    border = 'single' --[[ , title = ' hover '  ]],
  }
end, { desc = 'Hover Documentation' })

vim.keymap.set('n', ']n', ':lnext<CR>', { desc = 'Next location list item' })
vim.keymap.set('n', ']p', ':lprev<CR>', { desc = 'Prev location list item' })

vim.keymap.set('n', '<leader>s', '<C-^>', { noremap = true, silent = true })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows

--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('i', 'kj', '<ESC>')

-- Open Netrw
-- vim.keymap.set('n', '<leader>rw', '<cmd>Ex!<CR>')

-- Open Neotree
vim.keymap.set('n', '<leader>nt', '<cmd>:Neotree<CR>')

-- Oil nvim
vim.keymap.set('n', '-', '<CMD>Oil<CR>', { desc = 'Open parent directory' })

--Undo Tree
vim.keymap.set('n', '<leader><F5>', vim.cmd.UndotreeToggle)

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank { timeout = 70 }
  end,
})

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
require('lazy').setup({
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically
  'ThePrimeagen/vim-be-good',
  'mbbill/undotree',
  {
    'roobert/tailwindcss-colorizer-cmp.nvim',
    config = function()
      require('tailwindcss-colorizer-cmp').setup {
        color_square_width = 2,
        -- required for blink.cmp
        min_color_luminance = 0.3,
      }

      -- integrate with blink.cmp
      require('blink-cmp').setup {
        formatting = {
          format = require('tailwindcss-colorizer-cmp').formatter,
        },
      }
    end,
  },

  {
    'microsoft/vscode-js-debug',
    opt = true,
    run = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
  },

  {
    'stevearc/oil.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
      }
    end,
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    -- Enable to autostart at nvim .
    -- config = function()
    --   require('neo-tree').setup {}
    -- end,
  },

  -- NOTE: Plugins can also be added by using a table,
  -- with the first argument being the link and the following
  -- keys can be used to configure plugin behavior/loading/etc.
  --
  -- Use `opts = {}` to force a plugin to be loaded.
  -- NOTE plugins
  --
  --  This is equivalent to:
  -- require('Comment').setup({})

  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    opts = function()
      return {
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        ignore = '^$',
        opleader = {
          line = 'mc',
          block = 'mb',
        },
      }
    end,
  },

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    opts = {
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
      win = {
        no_overlap = true,
        border = 'rounded',
        padding = { 1, 2 }, -- top/bottom, left/right
      },
      layout = {
        spacing = 3, -- spacing between columns
      },

      -- Document existing key chains
      spec = {
        { '<leader>c', group = '[C]ode', mode = { 'n', 'x' } },
        { '<leader>d', group = '[D]ocument' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
      },
    },
  },

  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup {
        flavour = 'auto', -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = 'latte',
          dark = 'mocha',
        },
        transparent_background = true, -- disables setting the background color.
        show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
        term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
        dim_inactive = {
          enabled = false, -- dims the background color of inactive window
          shade = 'dark',
          percentage = 0.15, -- percentage of the shade to apply to the inactive window
        },
        no_italic = true, -- Force no italic
        no_bold = false, -- Force no bold
        no_underline = false, -- Force no underline
        --[[ styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
          -- comments = { 'italic' }, -- Change the style of comments
          -- conditionals = { 'italic' },
          loops = {},
          functions = {},
          keywords = {},
          strings = {},
          variables = {},
          numbers = {},
          booleans = {},
          properties = {},
          types = {},
          operators = {},
          -- miscs = {}, -- Uncomment to turn off hard-coded styles
        }, ]]
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
          cmp = true,
          gitsigns = true,
          nvimtree = true,
          treesitter = true,
          notify = false,
          mini = {
            enabled = true,
            indentscope_color = '',
          },
          -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
      }
      vim.cmd.colorscheme 'catppuccin'
      vim.o.background = 'dark'

      -- You can configure highlights by doing something like
      vim.cmd.hi 'Comment gui=none'
      vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' }) --Background (inside telescope)
      vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' }) --Weird Borderline
      vim.api.nvim_set_hl(0, 'NormalNC', { bg = 'none' }) --Background (outside telescope)
      vim.api.nvim_set_hl(0, 'WinSeparator', { fg = '#ffffff' }) --window separator
      vim.api.nvim_set_hl(0, 'NotificationInfo', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NotificationWarning', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NotificationError', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'CursorLineNr', { fg = '#a6e3a1', bg = 'none' })
      vim.cmd 'highlight TreesitterContextBottom guisp=#FFFFFF gui=underline'

      -- vim.api.nvim_set_hl(0, 'NormalFloat', { bg = '#111111' }) -- floating window bg color
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'FloatBorder', { bg = 'none' })
    end,
  },

  {
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    -- init = function()
    -- Load the colorscheme here.
    -- Like many other themes, this one has different styles, and you could load
    -- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
    -- vim.cmd.colorscheme 'tokyonight-night'

    -- You can configure highlights by doing something like:
    -- vim.cmd.hi 'Comment gui=none'
    -- end,
  },

  -- Highlight todo, notes, etc in comments
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.conform',
  -- require 'kickstart.plugins.dap',
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.fzf-telescope',
  require 'kickstart.plugins.lsp-config',
  require 'kickstart.plugins.blink-cmp',
  require 'kickstart.plugins.treesitter',
  require 'kickstart.plugins.nvim-lint',

  -- DB
  require 'kickstart.plugins.dadbod',

  -- Debugger
  -- require 'kickstart.plugins.dap',
  -- require 'kickstart.plugins.debug',

  require 'kickstart.plugins.live-server',
  require 'kickstart.plugins.vim-fugitive',
  require 'kickstart.plugins.mini',
  require 'kickstart.plugins.git-signs',
  -- require 'kickstart.plugins.copilot',
  -- Status column
  require 'kickstart.plugins.snacks',
  require 'kickstart.plugins.translate',
  -- Fold
  require 'kickstart.plugins.nvim-ufo-fold',

  require 'kickstart.plugins.lazy-git',

  -- require 'kickstart.plugins.nvim-cmp',
  -- require 'kickstart.plugins.cord',
  -- require 'kickstart.plugins.render-markdown',
  -- require 'kickstart.plugins.noice',

  -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`.
  --    For additional information, see `:help lazy.nvim-lazy.nvim-structuring-your-plugins`
  -- { import = 'custom.plugins' },
}, {
  ui = {
    border = 'single',
  },
})
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
