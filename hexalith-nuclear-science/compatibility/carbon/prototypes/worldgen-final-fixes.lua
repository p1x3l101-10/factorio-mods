local cfg = settings.startup["hexalith-nuclear-science-natural-gas"].value
local nauvis = data.raw.planet.nauvis
local hexalith = data.raw.planet.hexalith

if cfg = "no" then
  return
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
  -- Also remove the wellhead to make it fit in with other fluids
  local NGcfg = settings.startup["adamo-carbon-wellhead"]
  NGcfg.hidden = true
  NGcfg.forced_value = false
end