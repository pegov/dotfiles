return {
	"ray-x/go.nvim",
	tag = "v0.10.4",
	event = { "CmdlineEnter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
	dependencies = {
		"ray-x/guihua.lua",
	},
}
