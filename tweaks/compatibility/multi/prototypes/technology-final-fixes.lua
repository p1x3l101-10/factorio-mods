if mods["alloy-smelting"] and mods["lignumis"] and not mods["aai-industry"] then
  data.raw["technology"]["kiln-smelting"].prerequisites = { "automation-science-pack" }
end

if mods["lignumis"] and mods["More_Ammo"] then
  local recipes = data.raw["recipe"]
  recipes["empty-recipe"].enabled = false
  recipes["empty-shotgun-recipe"].enabled = false
  local iron_processing = data.raw["technology"]["iron-processing"]
  local copper_processing = data.raw["technology"]["copper-processing"]
  iron_processing.effects[#iron_processing.effects + 1] = { type = "unlock-recipe", recipe = "empty-recipe" }
  copper_processing.effects[#copper_processing.effects + 1] = { type = "unlock-recipe", recipe = "empty-shotgun-recipe" }
end

if mods["lignumis"] and mods["aai-industry"] then
  local red_science = data.raw["technology"]["automation-science-pack"]
  red_science.prerequisites[#red_science.prerequisites + 1] = { "copper-processing" }
end