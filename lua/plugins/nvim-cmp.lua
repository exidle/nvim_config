return {
	"hrsh7th/nvim-cmp",
	-- load cmp on InsertEnter
	 event = "InsertEnter",

	 -- these dependencies will only be loaded when cmp loads
	 -- dependencies are always lazy-loaded unless specified otherwise
	 dependencies = {
	   "hrsh7th/cmp-nvim-lsp",
	   "hrsh7th/cmp-buffer",
	   {
		   "L3MON4D3/LuaSnip",
		   version = "v2.*",
	   },

	   "rafamadriz/friendly-snippets",
	   "onsails/lspkind.nvim", -- vs-code like pictograms
	 },


	 config = function()
		local cmp = require("cmp")
		local lspkind = require("lspkind")
		local luasnip = require("luasnip")

		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.setup({
		    snippet = {
			expand = function(args)
			    luasnip.lsp_expand(args.body)
			end,
		    },
		    mapping = cmp.mapping.preset.insert({
			["<C-d>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(),
			["<C-e>"] = cmp.mapping.close(),
			["<CR>"] = cmp.mapping.confirm({
			    behavior = cmp.ConfirmBehavior.Replace,
			    select = true,
			}),
		    }),
		    sources = cmp.config.sources({
			{ name = "nvim_lsp" },
			{ name = "luasnip" },
			{ name = "buffer" },
			{ name = "path" },
		    }),
		})

		vim.cmd([[
	      set completeopt=menuone,noinsert,noselect
	      highlight! default link CmpItemKind CmpItemMenuDefault
	    ]])
	    end,
}
