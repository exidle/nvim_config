return {
	"echasnovski/mini.files",
	version = false,
	dependencies = "echasnovski/mini.icons",
	keys = {
		{ "<leader>e", function()
			local mf = require("mini.files")
			if not mf.close() then
				mf.open(vim.api.nvim_buf_get_name(0))
			end
		end, "MiniFiles open"},

		{ "<leader>E", function()
			local mf = require("mini.files")
			if not mf.close() then
				local dot_git_path = vim.fn.finddir(".git", ".;")
				local git_root = vim.fn.fnamemodify(dot_git_path, ":h")
				mf.open(git_root, false)
			end
		end, "MiniFiles open"},
	},

	config = function()
	      local map_split = function(buf_id, lhs, direction)
		local rhs = function()
		  -- Make new window and set it as target
		  local new_target_window
		  vim.api.nvim_win_call(require('mini.files').get_target_window(), function()
		    vim.cmd(direction .. ' split')
		    new_target_window = vim.api.nvim_get_current_win()
		  end)
	 
		  MiniFiles.set_target_window(new_target_window)
		end
	 
		-- Adding `desc` will result into `show_help` entries
		local desc = 'Split ' .. direction
		vim.keymap.set('n', lhs, rhs, { buffer = buf_id, desc = desc })
	      end
	 
	      vim.api.nvim_create_autocmd('User', {
		pattern = 'MiniFilesBufferCreate',
		callback = function(args)
		  local buf_id = args.data.buf_id
		  map_split(buf_id, 'gs', 'belowright vertical')
		end,
	      })
	      require('mini.files').setup()
	    end
	  }
