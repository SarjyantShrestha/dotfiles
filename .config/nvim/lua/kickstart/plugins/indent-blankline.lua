return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    opts = {
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
      },
    },
    config = function(_, opts)
      require("ibl").setup(opts)

      local function set_ibl_highlights()
        vim.api.nvim_set_hl(0, "IblScope", { fg = "#A0A9E5" })
      end

      -- apply now
      set_ibl_highlights()

      -- re-apply after colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = set_ibl_highlights,
      })
    end,
  },
}
