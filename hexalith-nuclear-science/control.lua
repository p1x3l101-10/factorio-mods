local handler = require("event_handler")

handler.add_libraries({
  require("scripts.difficulty")
})

-- Add planet for DERP
remote.call("diverse_external_rocket_parts", "add_custom_surface", "hexalith")