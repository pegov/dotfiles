require("toggle-pane"):entry("min-parent")
require("toggle-pane"):entry("min-preview")

th.git = th.git or {}
th.git.modified_sign = "M"
th.git.modified = ui.Style():fg("cyan"):bold()
th.git.added_sign = "A"
th.git.added = ui.Style():fg("green"):bold()
th.git.ignored_sign = "-"
th.git.ignored = ui.Style():fg("white"):bold()
th.git.updated_sign = "U"
th.git.updated = ui.Style():fg("cyan"):bold()
th.git.untracked_sign = "U+"
th.git.untracked = ui.Style():fg("cyan"):bold()
th.git.deleted_sign = "D"
th.git.deleted = ui.Style():fg("red"):bold()
require("git"):setup()
