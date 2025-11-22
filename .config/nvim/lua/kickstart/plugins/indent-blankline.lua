return {
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    ---@module "ibl"
    ---@type ibl.config
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      local hooks = require 'ibl.hooks'

      hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
        vim.api.nvim_set_hl(0, 'IblScope', { fg = '#A0A9E5' }) -- dim gray color
      end)

      require('ibl').setup(opts)
    end,
  },
}
