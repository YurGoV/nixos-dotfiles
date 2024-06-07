return {
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"bash-language-server",
				"css-lsp",
				"eslint-lsp",
				"gopls",
				"helm-ls",
				"html-lsp",
				"json-lsp",
				"jdtls",
				"marksman",
				"phpactor",
				"typescript-language-server",
				"vue-language-server",
			},
		},
	},
	{
		"nvim-lspconfig",
		keys = {
			{ "<leader>ce", "<cmd>EslintFixAll<cr>", desc = "ESLint Fix All" },
		},
		opts = {
			servers = {
				-- tsserver will be automatically installed with mason and loaded with lspconfig
				tsserver = {
					init_options = {
						plugins = {
							{
								name = "@vue/typescript-plugin",
								-- Change this to the location the plugin is installed to
								-- location = "/home/yurgo/.nvm/versions/node/v20.11.1/lib/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin",
								location = "/home/yurgo/.pnpm-global/global/5/.pnpm/@vue+typescript-plugin@2.0.19/node_modules/@vue/typescript-plugin",
								languages = { "javascript", "typescript", "vue" },
							},
						},
					},
					filetypes = {
						"javascript",
						"typescript",
						"vue",
					},
				},
			},
			-- setup = {
			--   volar = function()
			--     require("lazyvim.util").lsp.on_attach(function(client, _)
			--       if client.name == "volar" then
			--         client.server_capabilities.documentFormattingProvider = false
			--       end
			--     end)
			--   end,
			-- },
		},
	},
}
