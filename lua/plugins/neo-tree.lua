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
	opts = {
		sources = {"filesystem", "buffers", "git_status" },
		open_files_do_not_replace_types = { "terminal", "Trouble", "qf", "Outline" },
		filesystem = {
			bind_to_cwd = false,
			follow_current_file = { enabled = true },
		},
		default_component_settnigs = {
			git_status = {
				symbols = {
				        unstaged = "󰄱",
					staged = "󰱒",
				},
			},
		},
	},
}
