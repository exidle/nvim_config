return {
	"rcarriga/nvim-dap-ui",
	event = "VeryLazy",
	dependencies = { "mfussenegger/nvim-dap" , "nvim-neotest/nvim-nio"},
	keys = {
		{ "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle DAP UI" },
	},
	config = function()
		require("dapui").setup()
		local dap, dapui = require("dap"), require("dapui")
		dap.listeners.after.event_initialized["dapui_config"] = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated["dapui_config"] = function()
			dapui.close()
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			dapui.close()
		end
	end,
}
