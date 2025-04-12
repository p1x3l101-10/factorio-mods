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
          min = 1000,
          max = 1000
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
  if mods["maraxsis"] then
    local waterRocket = rocketItem:new("maraxis")
    waterRocket:setIngredients(
      {
        { "processing-unit", 2 },
        { "low-density-structure", 1 },
        { "rocket-fuel", 1 },
        { "maraxsis-super-sealant-substance", 1 }
      },
      {
        { "processing-unit", 10 },
        { "low-density-structure", 3 },
        { "rocket-fuel", 3 },
        { "maraxsis-glass-panes", 5 },
        { "maraxsis-salt", },
        { "maraxsis-super-sealant-substance", 5 }
      }
    )
    waterRocket:addPlanetImage("__planet-maraxis__/graphics/technology/maraxis.png", 256)
    waterRocket:setCrafter("maraxsis-hydro-plant-or-assembling")
    waterRocket:surfaceConditions(
      {
        { property = "pressure", min = 200000, max = 200000 }
      }
    )
    waterRocket:apply()
    -- Disable normal maraxis recipe
    local function removeEffect(techName, effect)
      local old_effects = data.raw["technology"][techName].effects
      local deleted = false
      local new_effects = {}
      for _, effect in pairs(old_effects) do
        if effect[1] == effect then
          deleted = true
        else
          new_effects[#new_effects + 1] = effect
      end
      if deleted then
        old_effects = new_effects
      end
      return deleted
    end
  end
  removeEffect("maraxsis-project-seadragon", "maraxsis-rocket-part")
  removeEffect("rocket-part-productivity", "maraxsis-rocket-part")
  data.raw.recipe["rocket-part"].surface_conditions = nil
end