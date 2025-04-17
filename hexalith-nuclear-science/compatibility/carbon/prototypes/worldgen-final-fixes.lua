local cfg = settings.startup["hexalith-nuclear-science-natural-gas"].value
local nauvis = data.raw.planet.nauvis
local hexalith = data.raw.planet.hexalith

-- Do nothing if the compat is off
if cfg == "no" then
  return
end

-- If the mod that makes oil limited exists, do that too
if mods["finite-oil-port"] then
  local ng = data.raw["resource"]["adamo-carbon-natural-gas"]
  ng.infinite = false
  ng.minimum = 25000
  ng.normal = 100000
  ng.infinite_depletion_amount = 5
  ng.minable = {
    mining_time = 0.5,
    results = {
      {
        type = "fluid",
        name = "adamo-carbon-natural-gas",
        amount_min = 10,
        amount_max = 10,
        probability = 1
      }
    }
  }
end

---- Copy or move
-- NG should replace oil
hexalith.map_gen_settings.autoplace_controls.aquilo_crude_oil = nil
hexalith.map_gen_settings.autoplace_settings.entity.settings["crude-oil"] = nil
-- Add NG
hexalith.map_gen_settings.autoplace_controls["adamo-carbon-natural-gas"] = table.deepcopy(nauvis.map_gen_settings.autoplace_controls["adamo-carbon-natural-gas"])
hexalith.map_gen_settings.autoplace_settings.entity.settings["adamo-carbon-natural-gas"] = table.deepcopy(nauvis.map_gen_settings.autoplace_settings.entity.settings["adamo-carbon-natural-gas"])


  
if cfg == "move" then
  -- Remove NG from Nauvis
  nauvis.map_gen_settings.autoplace_controls["adamo-carbon-natural-gas"] = nil
  nauvis.map_gen_settings.autoplace_settings.entity.settings["adamo-carbon-natural-gas"] = nil
end