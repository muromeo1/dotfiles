return {
  "sudo-tee/opencode.nvim",
  event = "VeryLazy",
  config = function()
    require("opencode").setup({
      preferred_picker = "fzf",
      default_mode = "orchestrator",
      keymap = {
        input_window = {
          ["<tab>"] = { "switch_mode", mode = { "n", "i" }, desc = "Switch between modes (build/plan)" },
          ["<C-s>"] = {
            "submit_input_prompt",
            mode = { "n", "i" },
            desc = "Submit prompt (normal mode)",
          },
        },
      },
      ui = {
        input = {
          text = {
            wrap = true, -- wrap text on input window
          },
        },
        output = {
          -- always_scroll_to_bottom = true,
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
    "ibhagwan/fzf-lua",
  },
}
