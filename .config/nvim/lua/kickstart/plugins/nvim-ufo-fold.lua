return {
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = "BufReadPost", -- Only load when opening a file
  init = function()
    -- UFO requires these options set early
    vim.o.foldcolumn = '1' -- '0' is fine if you want no fold indicator
    vim.o.foldlevel = 99
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function()
    -- Keymaps for UFO
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = "Open all folds" })
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = "Close all folds" })

    -- Treesitter only setup
    require('ufo').setup({
      provider_selector = function(bufnr, filetype, buftype)
        return { 'treesitter', 'indent' }
      end
    })
  end,
}
