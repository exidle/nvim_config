return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
	  "nvim-lua/plenary.nvim",
	  "MunifTanjim/nui.nvim"
  },
    keys = {
      { "<leader>tt", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup()
    end,
}
