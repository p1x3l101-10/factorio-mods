if mods["diverse-external-rocket-parts"] then
  local rocketItem = require("__p1x3l101-shared-parts__/lib").optional.diverse_external_rocket_parts
  if mods["lignumis"] then
    local ligRocket = rocketItem:new("lignumis")
    ligRocket:setIngredients(
      {
        { "advanced-circuit", 2 },
        { "low-density-structure", 1 },
        { "rocket-fuel", 1 },
        { "gold-plate", 5 }
      },
      {
        { "processing-unit", 2 },
        { "low-density-structure", 5 },
        { "rocket-fuel", 5 },
        { "gold-plate", 20 }
      }
    )
    ligRocket:addPlanetImage("__lignumis-assets__/graphics/icons/lignumis.png", 64)
    ligRocket:add_surfaceConditions(
      {
        {
          property = "pressure",
          min = 900,
          max = 900
        },
        {
          property = "gravity",
          min = 4,
          max = 4
        }
      }
    )
    ligRocket:unlockedBy("space-platform-thruster")
    ligRocket:setCrafter("crafting-with-steam")
    ligRocket:apply()
  end
end