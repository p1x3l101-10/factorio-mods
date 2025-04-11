local util = require("functions").recipe

-- Pick the rocket part ingredient
local uraniumRocketItem = "uranium-238"
if mods["SchallUraniumProcessing"] then
  uraniumRocketItem = "uranium-concentrate"
end

local rocketFuel = "rocket-fuel"
if settings.startup["expensive-mode"].value then
  rocketFuel = "nuclear-fuel"
end

-- Create hexalith rocket recipe
data:extend({
  {
    type = "recipe",
    name = "rocket-part-hexalith",
    localised_name = {"item-name.rocket-part"},
    localised_description = {"item-description.rocket-part"},
    energy_required = 5,
    enabled = false,
    hide_from_player_crafting = false,
    category = "centrifuging",
    subgroup = "space-rocket",
    ingredients = {
      {type = "item", name = "processing-unit", amount = settings.startup["external-rocket-part-cost-setting"].value },
      {type = "item", name = "low-density-structure", amount = settings.startup["external-rocket-part-cost-setting"].value },
      {type = "item", name = rocketFuel, amount = settings.startup["external-rocket-part-cost-setting"].value },
      {type = "item", name = uraniumRocketItem, amount = 10*settings.startup["external-rocket-part-cost-setting"].value }
    },
    results = {{type="item", name="rocket-part", amount=1}},
    allow_productivity = true,
    allow_quality = false,
    icons = {
      {icon = "__base__/graphics/icons/rocket-part.png", icon_size=64},
      {icon = "__hexalith-nuclear-science__/graphics/technology/hexalith.png", scale=0.25, shift={-8,8}}
    },
    surface_conditions = {
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
  }
})

-- Remove uranium from nauvis rocket
util.delete_ingriedent("rocket-part-ext", "uranium-238")
util.set_category("rocket-part-ext", "crafting")
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

-- Add recipe to relivant techs
table.insert(data.raw.technology["uranium-processing"].effects,{ type = "unlock-recipe", recipe = "rocket-part-hexalith" })
table.insert(data.raw.technology["rocket-part-productivity"].effects, { type = "change-recipe-productivity", recipe = "rocket-part-hexalith", change = 0.1 })