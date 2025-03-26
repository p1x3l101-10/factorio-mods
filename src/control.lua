local handler = require("event_handler")

handler.add_libraries({
  require("scripts.difficulty")
})

if script.active_mods["lignumis"] then
  require("compatibility.lignumis.control")
end