local util = require("functions").recipe
local rocketItem = require("__p1x3l101-shared-parts__/lib").optional.diverse_external_rocket_parts

-- Pick the rocket part ingredient
local uraniumRocketItem = "uranium-238"
if mods["SchallUraniumProcessing"] then
  uraniumRocketItem = "uranium-concentrate"
end

-- Create hexalith rocket recipe
local rocketPartHex = rocketItem:new("hexalith")
rocketPartHex:setIngredients(
  {
    { "processing-unit", 1 },
    { "low-density-structure", 1 },
    { "rocket-fuel", 1 },
    { uraniumRocketItem, 10 }
  },
  {
    { "processing-unit", 2 },
    { "low-density-structure", 5 },
    { "nuclear-fuel", 1 },
    { uraniumRocketItem, 10 }
  }
)
rocketPartHex:addPlanetImage("__hexalith-nuclear-science__/graphics/technology/hexalith.png", 512)
rocketPartHex:add_surfaceConditions(
  {
    {
      property = "pressure",
      min = 1000,
      max = 1000
    },
    { -- Ensure hexalith
      property = "gravity",
      min = 12,
      max = 12
    }
  }
)
rocketPartHex:unlockedBy("uranium-processing")
rocketPartHex:setCrafter("advanced-centrifuging-or-crafting")
rocketPartHex:apply()

-- Remove uranium from nauvis rocket
util.delete_ingriedent("rocket-part-ext", "uranium-238")
util.set_category("rocket-part-ext", "advanced-crafting")
-- Fix nauvis rocket parts
if settings.startup["expensive-mode"].value then
  util.delete_ingriedent("rocket-part-ext", "nuclear-fuel")
  util.add_ingredient("rocket-part-ext", {type = "item", name = "rocket-fuel", amount = 5*settings.startup["external-rocket-part-cost-setting"].value })
end
util.set_surface_conditions("rocket-part-ext", {
  {
    property = "pressure",
    min = 1000,
    max = 1000
  },
  { -- Ensure nauvis
    property = "gravity",
    min = 10,
    max = 10
  }
})