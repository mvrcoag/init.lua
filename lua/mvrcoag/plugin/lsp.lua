vim.opt.signcolumn = "yes"

local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
	vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "LSP actions",
	callback = function(event)
		local opts = { buffer = event.buf }

		vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
		vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
		vim.keymap.set("n", "<leader>D", "<cmd>lua vim.diagnostic.open_float()<cr>", opts)
		vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<cr>", opts)
		vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<cr>", opts)
		vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
		vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
		vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
		vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
		vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
		vim.keymap.set("n", "rn", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
		vim.keymap.set("n", "ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	end,
})

require("mason").setup()

local servers = {
	"lua_ls",
	"vtsls",
	"gopls",
	"eslint",
	"intelephense",
	"gopls",
	"pyright",
}

require("mason-lspconfig").setup({
	ensure_installed = servers,
	handlers = {
		function(server_name)
			require("lspconfig")[server_name].setup({})
		end,
	},
})

local cmp = require("cmp")

local cmp_select = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
	sources = {
		{ name = "nvim_lsp" },
		{ name = "path" },
	},
	snippet = {
		expand = function(args)
			-- You need Neovim v0.10 to use vim.snippet
			vim.snippet.expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<CR>"] = cmp.mapping.confirm({ select = true }),
		["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
		["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
		["<C-Space>"] = cmp.mapping.complete(),
	}),
})
