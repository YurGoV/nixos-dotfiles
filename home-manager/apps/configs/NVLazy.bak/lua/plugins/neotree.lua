return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    config = function(_, config)
      local tree = require("neo-tree")
      tree.setup({
        window = {
          mapping_options = {
            noremap = true,
            -- noremap = false,
            nowait = true,
          },
          mappings = {
            ["l"] = "open",
            ["h"] = "close_node",
            -- ["p"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
          },
        },
      })
      --[[ vim.keymap.set("n", "<C-n>", ":Neotree filesystem reveal left<CR>", {})
      vim.keymap.set("n", "<leader>bf", ":Neotree buffers reveal float<CR>", {}) ]]
    end,
  },
}
