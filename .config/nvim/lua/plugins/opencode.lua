return {
  "sudo-tee/opencode.nvim",
  config = function()
    require("opencode").setup({
      keymap = {
        input_window = {
          ["<tab>"] = { "switch_mode", mode = { "n", "i" } }, -- Switch between modes (build/plan)
        },
      },
      ui = {
        input = {
          text = {
            wrap = true, -- wrap text on input window
          },
        },
      },
    })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
}
