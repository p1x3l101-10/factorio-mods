local bigunpack = require("__big-data-string2__.unpack")
local function discover_applied_surfaces()
  local decode = serpent.load
  local function getData(name)
    return decode(bigunpack(name))
  end
  local planets = getData("DERP_Planet_Rockets")
  return planets
end

script.on_configuration_changed(function()
  if not script.active_mods["diverse-external-rocket-parts"] then return end
  for _, surface in pairs(discover_applied_surfaces()) do
    remote.call("diverse_external_rocket_parts", "add_custom_surface", surface)
  end
end)