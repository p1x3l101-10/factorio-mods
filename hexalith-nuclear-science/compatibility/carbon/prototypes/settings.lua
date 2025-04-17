if settings.startup["hexalith-nuclear-science-natural-gas"].value == "move" then
  -- Remove wellhead to make NG fit in with other fluids
  local NGcfg = settings.startup["adamo-carbon-wellhead"]
  NGcfg.hidden = true
  NGcfg.forced_value = false
  -- Because carbon does everything in data stage, I need to override it here
  data.raw["resource"]["adamo-carbon-natural-gas"].category = "basic-fluid"
  data.raw["resource-category"]["adamo-carbon-gas"] = nil
  data.raw["mining-drill"]["adamo-carbon-gas-wellhead"] = nil
  data.raw["item"]["adamo-carbon-gas-wellhead"] = nil
  data.raw["recipe"]["adamo-carbon-gas-wellhead"] = nil
  local tech = require("functions").tech
  local effect = { type = "recipe", recipe = "adamo-carbon-gas-wellhead" }
  tech.delete_effect("oil-processing", effect)
  tech.delete_effect("adamo-carbon-gas-processing", effect)
end