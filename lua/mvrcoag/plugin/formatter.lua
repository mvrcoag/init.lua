require("formatter").setup({
	filetype = {
		lua = require("formatter.filetypes.lua").stylua,
		javascript = require("formatter.filetypes.javascript").prettier,
		typescript = require("formatter.filetypes.javascript").prettier,
		typescriptreact = require("formatter.filetypes.javascript").prettier,
		javascriptreact = require("formatter.filetypes.javascript").prettier,
		php = require("formatter.filetypes.php").php_cs_fixer,
		python = require("formatter.filetypes.python").black,
		go = require("formatter.filetypes.go").gofmt,
	},
})
