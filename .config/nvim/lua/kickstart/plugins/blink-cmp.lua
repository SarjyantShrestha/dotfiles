return {
  'Saghen/blink.cmp',
  enabled = true,
  version = '*',
  build = 'cargo build --release',
  dependencies = {
    -- 'mikavilpas/blink-ripgrep.nvim',
    {
      'L3MON4D3/LuaSnip',
      config = function()
        local ls = require 'luasnip'
        vim.keymap.set({ 'i', 's' }, '<Tab>', function()
          if ls.expand_or_jumpable() then
            ls.expand_or_jump()
          else
            return '<Tab>'
          end
        end, { expr = true, silent = true })

        vim.keymap.set({ 'i', 's' }, '<S-Tab>', function()
          if ls.jumpable(-1) then
            ls.jump(-1)
          else
            return '<S-Tab>'
          end
        end, { expr = true, silent = true })
      end,
      version = 'v2.*',
      build = 'make install_jsregexp',
      dependencies = {
        'rafamadriz/friendly-snippets',
        config = function()
          require('luasnip.loaders.from_vscode').lazy_load()
          -- require('luasnip.loaders.from_vscode').lazy_load { paths = { vim.fn.stdpath 'config' .. '/snippets' } }

          local extends = {
            typescript = { 'tsdoc' },
            javascript = { 'jsdoc' },
            lua = { 'luadoc' },
            python = { 'pydoc' },
            rust = { 'rustdoc' },
            cs = { 'csharpdoc' },
            java = { 'javadoc' },
            c = { 'cdoc' },
            cpp = { 'cppdoc' },
            php = { 'phpdoc' },
            kotlin = { 'kdoc' },
            ruby = { 'rdoc' },
            sh = { 'shelldoc' },
          }
          -- friendly-snippets - enable standardized comments snippets
          for ft, snips in pairs(extends) do
            require('luasnip').filetype_extend(ft, snips)
          end
        end,
      },
      opts = { history = true, delete_check_events = 'TextChanged' },
    },
  },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      menu = { border = 'single' },
      documentation = { window = { border = 'single' }, auto_show = true, auto_show_delay_ms = 500 },
    },
    signature = { enabled = true, window = { border = 'single' } },
    snippets = { preset = 'luasnip' },
    sources = {
      default = {
        'lsp',
        'path',
        'buffer',
        'snippets',
        -- 'ripgrep',
      },
      -- providers = {
      --   ripgrep = {
      --     module = 'blink-ripgrep',
      --     name = 'Ripgrep',
      --     ---@module "blink-ripgrep"
      --     ---@type blink-ripgrep.Options
      --     opts = {
      --       prefix_min_len = 4,
      --       score_offset = 10, -- should be lower priority
      --       max_filesize = '300K',
      --       search_casing = '--smart-case',
      --     },
      --   },
      -- },
    },
    fuzzy = { implementation = 'prefer_rust_with_warning' },
  },
  opts_extend = { 'sources.default' },
}
