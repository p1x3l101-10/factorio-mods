if mods["alloy-smelting"] and mods["lignumis"] then
  data.raw["technology"]["kiln-smelting"].prerequisites = { "planet-discovery-nauvis" }
end

if mods["lignumis"] and mods["More_Ammo"] then
  local recipes = data.raw["recipe"]
  recipes["empty-recipe"].enabled = false
  recipes["empty-shotgun-recipe"].enabled = false
  local discover_nauvis = data.raw["technology"]["planet-discovery-nauvis"]
  discover_nauvis.effects[#discover_nauvis.effects + 1] = { type = "unlock-recipe", recipe = "empty-recipe" }
  discover_nauvis.effects[#discover_nauvis.effects + 1] = { type = "unlock-recipe", recipe = "empty-shotgun-recipe" }
end