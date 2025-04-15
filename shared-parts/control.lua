local bigunpack = require("__big-data-string2__.unpack")
local decode = serpent.load
local function getData(name)
  local ok, copy = decode(bigunpack(name))
  return copy
end

script.on_configuration_changed(function()
  if not script.active_mods["diverse-external-rocket-parts"] then return end
  for _, surface in ipairs(getData("DERP_Planet_Rockets")) do
    log("Registered DERP surface: ".. surface)
    remote.call("diverse_external_rocket_parts", "add_custom_surface", surface)
  end
end)