return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPost", "BufNewFile" },
	config = function()
		local lspconfig = require('lspconfig')

		local map = function(type, key, value)
			vim.api.nvim_buf_set_keymap(0, type, key, value, {noremap = true, silent = true});
		end

		local custom_attach = function(client)
			map('n','gD','<cmd>lua vim.lsp.buf.declaration()<CR>')
			map('n','gd','<cmd>lua vim.lsp.buf.definition()<CR>')
			map('n','K','<cmd>lua vim.lsp.buf.hover()<CR>')
			map('n','gr','<cmd>lua vim.lsp.buf.references()<CR>')
			map('n','gs','<cmd>lua vim.lsp.buf.signature_help()<CR>')
			map('n','gi','<cmd>lua vim.lsp.buf.implementation()<CR>')
			map('n','gt','<cmd>lua vim.lsp.buf.type_definition()<CR>')
			map('n','<leader>gw','<cmd>lua vim.lsp.buf.document_symbol()<CR>')
			map('n','<leader>gW','<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
			map('n','<leader>ah','<cmd>lua vim.lsp.buf.hover()<CR>')
			map('n','<leader>af','<cmd>lua vim.lsp.buf.code_action()<CR>')
			map('n','<leader>ee','<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>')
			map('n','<leader>ar','<cmd>lua vim.lsp.buf.rename()<CR>')
			map('n','<leader>=', '<cmd>lua vim.lsp.buf.formatting()<CR>')
			map('n','<leader>ai','<cmd>lua vim.lsp.buf.incoming_calls()<CR>')
			map('n','<leader>ao','<cmd>lua vim.lsp.buf.outgoing_calls()<CR>')
			map('n','<leader>gS','<cmd>ClangdSwitchSourceHeader<CR>')
		end

		lspconfig.clangd.setup({
			cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
			filetypes = { "cc", "cpp" },
			on_attach = custom_attach,
		})

		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(args)
			local client = vim.lsp.get_client_by_id(args.data.client_id)

				if client.supports_method('textDocument/formatting') then
					-- Format the current buffer on save
					vim.api.nvim_create_autocmd('BufWritePre', {
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({bufnr = args.buf, id = client.id })
						end,
					})
				end
			end
		})
	end,
}
