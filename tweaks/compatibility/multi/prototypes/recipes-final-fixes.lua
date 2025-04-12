if mods["maraxsis"] and mods["diverse-external-rocket-parts"] then
  -- New rocket part
  local rocketItem = require("__p1x3l101-shared-parts__/lib").optional.diverse_external_rocket_parts
  local waterRocket = rocketItem:new("maraxsis")
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
      { "maraxsis-salt", 1 },
      { "maraxsis-super-sealant-substance", 5 }
    }
  )
  waterRocket:addPlanetImage("__planet-maraxis__/graphics/technology/maraxis.png", 256)
  waterRocket:unlockedBy("maraxsis-project-seadragon")
  waterRocket:setCrafter("maraxsis-hydro-plant-or-assembling")
  waterRocket:add_surfaceConditions(
    {
      { property = "pressure", min = 200000, max = 200000 }
    }
  )
  waterRocket:apply()
  -- Disable normal maraxis recipe
  local function removeEffect(techName, type, name)
    local old_effects = data.raw["technology"][techName].effects
    local deleted = false
    local new_effects = {}
    for i = #old_effects, 1, -1 do
      local effect = old_effects[i]
      if effect.type == type and effect.name == name then
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
  removeEffect("maraxsis-project-seadragon", "recipe", "maraxsis-rocket-part")
  removeEffect("rocket-part-productivity", "change-recipe-productivity", "maraxsis-rocket-part")
  data.raw.recipe["rocket-part"].surface_conditions = nil
  data.raw["recipe"]["maraxsis-rocket-part"] = nil
end