return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' },
      scope = { enabled = false },
    },
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yin' - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      local statusline = require 'mini.statusline'
      statusline.setup { use_icons = true, set_vim_settings = false }

      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return '%2l:%-2v'
      end

      -- Create a custom highlight group for transparent background on filename
      vim.cmd [[
        hi StatusFilename guibg=NONE guifg=#ffffff ctermfg=white ctermbg=NONE
      ]]

      -- Override filename section to use the custom highlight group
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_filename = function()
        local filename = vim.fn.expand '%:~:.'
        if filename == '' then
          filename = '[No Name]'
        end
        -- Use custom highlight group "StatusFilename"
        return string.format('%%#StatusFilename# %s ', filename)
      end
    end,
  },
}
