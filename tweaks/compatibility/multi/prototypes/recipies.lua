local Recipe = require("__cf-lib__/data/Recipe")

if mods["wood-military"] and mods["More_Ammo"] and settings.startup["wood-military-smg-ammo"].value then
  Recipe:new("wood-darts-magazine"):removeIngredient("empty-magazine")
  Recipe:new("wood-shotgun-shell"):removeIngredient("empty-shotgun-shell")
end

if mods["lignumis"] and mods["More_Ammo"] then
  Recipe:new("empty-recipe"):unlockedByTechnology("iron-processing")
  Recipe:new("empty-shotgun-recipe"):unlockedByTechnology("iron-processing")
  if settings.startup["high-capacity-magazines"].value then
    Recipe:new("empty-high-capacity-magazine"):unlockedByTechnology("iron-processing")
    Recipe:new("empty-high-capacity-shotgun-shell"):unlockedByTechnology("iron-processing")
  end
end