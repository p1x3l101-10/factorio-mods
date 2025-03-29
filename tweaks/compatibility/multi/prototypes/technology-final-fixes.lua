if mods["alloy-smelting"] and mods["lignumis"] and not mods["aai-industry"] then
  data.raw["technology"]["kiln-smelting"].prerequisites = { "automation-science-pack" }
end

if mods["lignumis"] and mods["More_Ammo"] then
  local recipes = data.raw["recipe"]
  recipes["empty-recipe"].enabled = false
  recipes["empty-shotgun-recipe"].enabled = false
  local iron_processing = data.raw["technology"]["iron-processing"]
  iron_processing.effects[#discover_nauvis.effects + 1] = { type = "unlock-recipe", recipe = "empty-recipe" }
  iron_processing.effects[#discover_nauvis.effects + 1] = { type = "unlock-recipe", recipe = "empty-shotgun-recipe" }
end

if mods["lignumis"] and mods["aai-industry"] then
  data.raw["technology"]["automation-science-pack"].prerequisites = { "copper-processing" }
end