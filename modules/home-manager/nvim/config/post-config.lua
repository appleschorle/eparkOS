local ibl = require("ibl")
local hooks = require("ibl.hooks")

-- Material-UI Dark Hard Gruvbox
local colors = {
	GruvboxRed = "#EA6962",
	GruvboxGreen = "#A9B665",
	GruvboxYellow = "#D8A657",
	GruvboxBlue = "#7DAEA3",
	GruvboxPurple = "#D3869B",
	GruvboxAqua = "#89B482",
	GruvboxFg = "#D4BE98",
}

local highlight = {
	"GruvboxRed",
	"GruvboxGreen",
	"GruvboxYellow",
	"GruvboxBlue",
	"GruvboxPurple",
	"GruvboxAqua",
	"GruvboxFg",
}

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	for name, hex in pairs(colors) do
		vim.api.nvim_set_hl(0, name, { fg = hex })
	end
end)

vim.g.rainbow_delimiters = { highlight = highlight }
ibl.setup({
	indent = { highlight = highlight },
})

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
