return {
	"ray-x/go.nvim",
	commit = "79b6de4e4565965a31098f453433df252a989f49",
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
	dependencies = {
		"ray-x/guihua.lua",
	},
}
