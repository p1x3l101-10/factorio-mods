if settings.startup["hexalith-nuclear-science-strict-biotech"].value then
  local recipe = require("functions").recipe
  local entity = require("functions").entity
  local hexSurface = {
    {
      property = "pressure",
      min = 1000,
      max = 1000
    },
    {
      property = "gravity",
      min = 12,
      max = 12
    }
  }
  recipe.set_surface_conditions("fish-breeding", hexSurface)
  recipe.set_surface_conditions("biter-egg", hexSurface)
  entity.set_surface_conditions("captive-biter-spawner", "assembling-machine", hexSurface)
  entity.set_surface_conditions("biolab", "lab", hexSurface)
  if settings.startup["hexalith-nuclear-science-strict-biotech-wood"].value then
    recipe.set_surface_conditions("wood-processing", hexSurface)
  end
end