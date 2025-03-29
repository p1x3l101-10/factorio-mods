if mods["alloy-smelting"] and mods["lignumis"] and not mods["aai-industry"] then
  data.raw["technology"]["kiln-smelting"].prerequisites = { "automation-science-pack" }
end

if mods["lignumis"] and mods["More_Ammo"] then
  local recipes = data.raw["recipe"]
  recipes["empty-recipe"].enabled = false
  recipes["empty-shotgun-recipe"].enabled = false
  local iron_processing = data.raw["technology"]["iron-processing"].effects
  local copper_processing = data.raw["technology"]["copper-processing"].effects
  iron_processing[#iron_processing + 1] = { type = "unlock-recipe", recipe = "empty-recipe" }
  copper_processing[#copper_processing + 1] = { type = "unlock-recipe", recipe = "empty-shotgun-recipe" }
end

if mods["lignumis"] and mods["aai-industry"] then
  local red_science = data.raw["technology"]["automation-science-pack"].prerequisites
  if not red_science
    red_science = {}
  end
  red_science[#red_science + 1] = { "copper-processing" }
end