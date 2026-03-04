return {
  'uga-rosa/translate.nvim',
  keys = {
    -- ENGLISH (e)
    { "<leader>tef", ":Translate EN<CR>",                 mode = "v", desc = "English: Float" },
    { "<leader>ter", ":Translate EN -output=replace<CR>", mode = "v", desc = "English: Replace" },
    { "<leader>tei", ":Translate EN -output=insert<CR>",  mode = "v", desc = "English: Insert" },

    -- JAPANESE (j)
    { "<leader>tjf", ":Translate JA<CR>",                 mode = "v", desc = "Japanese: Float" },
    { "<leader>tjr", ":Translate JA -output=replace<CR>", mode = "v", desc = "Japanese: Replace" },
    { "<leader>tji", ":Translate JA -output=insert<CR>",  mode = "v", desc = "Japanese: Insert" },
  },
  config = function()
    require("translate").setup({
      default = {
        command = "translate_shell", -- options: "google", "deepl_pro", "deepl_free", "translate_shell"
        output = "floating",         -- options: "floating", "split", "insert", "replace", "register"
      },
      preset = {
        output = {
          split = {
            append = true,
          },
        },
      },
    })
  end
}
