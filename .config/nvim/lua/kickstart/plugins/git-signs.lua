return {
  -- Here is a more advanced example where we pass configuration
  -- options to `gitsigns.nvim`. This is equivalent to the following lua:
  --    require('gitsigns').setup({ ... })
  --
  -- See `:help gitsigns` to understand what the configuration keys do
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol',    -- end-of-line virtual text
        delay = 300,              -- minimal delay before showing blame
        ignore_whitespace = true, -- skip whitespace-only changes
        current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      },
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
    keys = {
      { "<leader>gb", function() require("gitsigns").toggle_current_line_blame() end, desc = "Toggle line blame" },

      { "]g",         function() require("gitsigns").nav_hunk() end,                  desc = "Next Git hunk" },
      { "[g",         function() require("gitsigns").nav_hunk() end,                  desc = "Previous Git hunk" },

      { "<leader>gl", function() require("gitsigns").blame_line() end,                desc = "View Git blame" },
      { "<leader>gL", function() require("gitsigns").blame_line({ full = true }) end, desc = "View full Git blame" },

      { "<leader>gp", function() require("gitsigns").preview_hunk() end,              desc = "Preview Git hunk" },
      { "<leader>gh", function() require("gitsigns").reset_hunk() end,                desc = "Reset Git hunk" },
      { "<leader>gr", function() require("gitsigns").reset_buffer() end,              desc = "Reset Git buffer" },

      { "<leader>gs", function() require("gitsigns").stage_hunk() end,                desc = "Stage / Unstage Git hunk" },
      { "<leader>gS", function() require("gitsigns").stage_buffer() end,              desc = "Stage Git buffer" },

      { "<leader>gd", function() require("gitsigns").diffthis() end,                  desc = "View Git diff" },
    },
  },

}
