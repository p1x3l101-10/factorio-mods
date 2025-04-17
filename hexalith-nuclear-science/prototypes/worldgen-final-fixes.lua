local nauvis = data.raw.planet.nauvis
local hexalith = data.raw.planet.hexalith
local aquilo = data.raw.planet.aquilo

-- Remove uranium from nauvis generation
nauvis.map_gen_settings.autoplace_controls["uranium-ore"] = nil
nauvis.map_gen_settings.autoplace_settings.entity.settings["uranium-ore"] = nil

-- Also remove fish for good measure
nauvis.map_gen_settings.autoplace_settings.entity.settings.fish = nil

-- Apply nauvis difficulty changes
if settings.startup["hexalith-nuclear-science-peaceful-nauvis"].value then
  nauvis.pollutant_type = nil
  nauvis.map_gen_settings.autoplace_controls["enemy-base"] = nil
  nauvis.map_gen_settings.property_expression_names.enemy_base_frequency = 0
  nauvis.localised_description = {"space-location-description.nauvis-safe"}
end

-- Put oil on hexalith
hexalith.map_gen_settings.autoplace_controls.aquilo_crude_oil = table.deepcopy(aquilo.map_gen_settings.autoplace_controls.aquilo_crude_oil)
hexalith.map_gen_settings.autoplace_settings.entity.settings["crude-oil"] = table.deepcopy(aquilo.map_gen_settings.autoplace_settings.entity.settings["crude-oil"])

-- Apply hexalith difficulty changes
local difficulty = settings.startup["hexalith-nuclear-science-hexalith-difficulty"].value
if difficulty == "easy" then
  data.raw["noise-expression"]["hexalith_enemy_base_radius"].expression = 200
elseif difficulty == "baby" then
  data.raw["noise-expression"]["hexalith_enemy_base_radius"].expression = 400
else -- Purge the oil when using original difficulty
  hexalith.map_gen_settings.autoplace_controls.aquilo_crude_oil = nil
  hexalith.map_gen_settings.autoplace_settings.entity.settings["crude-oil"] = nil
end