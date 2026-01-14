return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    opts = {
      indent = { char = '│' }, -- Style for the background lines
      scope = { enabled = false }, -- Disable its internal scope so mini handles it
    },
  },
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yin' - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      local statusline = require 'mini.statusline'
      -- set use_icons to true if you have a Nerd Font
      statusline.setup { use_icons = true, set_vim_settings = false }

      -- local indentscope = require('mini.indentscope')
      -- indentscope.setup({
      --   symbol = '│',
      --   draw = {
      --     delay = 0,
      --     priority = 2,
      --     animation = indentscope.gen_animation.cubic({
      --       duration = 100,
      --       unit = 'total',
      --     }),
      --   },
      --   mappings = {
      --     object_scope = 'ii',
      --     object_scope_with_border = 'ai',
      --     goto_top = '[i',
      --     goto_bottom = ']i',
      --   },
      --   options = {
      --     border = 'both',
      --     indent_at_cursor = true,
      --     n_lines = 10000,
      --     try_as_border = false,
      --   },
      -- })

      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
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
