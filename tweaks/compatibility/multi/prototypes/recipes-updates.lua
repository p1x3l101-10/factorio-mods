if mods["diverse-external-rocket-parts"] and mods["lignumis"] then
  data:extend({
    {
      type = "recipe",
      name = "rocket-part-lignumis",
      localised_name = {"item-name.rocket-part"},
      localised_description = {"item-description.rocket-part"},
      energy_required = 5,
      enabled = false,
      hide_from_player_crafting = false,
      category = "crafting-with-steam",
      subgroup = "space-rocket",
      ingredients = {
        {type = "item", name = "advanced-circuit", amount = 5*settings.startup["external-rocket-part-cost-setting"].value },
        {type = "item", name = "low-density-structure", amount = settings.startup["external-rocket-part-cost-setting"].value },
        {type = "item", name = "rocket-fuel", amount = 2*settings.startup["external-rocket-part-cost-setting"].value },
        {type = "item", name = "gold-plate", amount = 20*settings.startup["external-rocket-part-cost-setting"].value }
      },
      results = {{type="item", name="rocket-part", amount=1}},
      allow_productivity = true,
      allow_quality = false,
      icons = {
        {icon = "__base__/graphics/icons/rocket-part.png", icon_size=64},
        {icon = "__lignumis-assets__/graphics/icons/lignumis.png", icon_size=64, scale=0.25, shift={-8,8}}
      },
      surface_conditions = {
        {
          property = "pressure",
          min = 1000,
          max = 1000
        },
        { -- Ensure lignumis
          property = "gravity",
          min = 4,
          max = 4
        }
      }
    }
  })
end