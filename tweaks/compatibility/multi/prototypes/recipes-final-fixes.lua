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
  local function removeEffect(techName, effectType, target)
    local tech = data.raw["technology"][techName]
    if not tech or not tech.effects then return false end
  
    local new_effects = {}
    local deleted = false
  
    for _, effect in ipairs(tech.effects) do
      local match =
        (effectType == "unlock-recipe" and effect.recipe == target) or
        (effectType == "nothing" and effect.effect_description == target) or
        (effectType == effect.type and effect.name == target)
  
      if not match then
        table.insert(new_effects, effect)
      else
        deleted = true
      end
    end
  
    tech.effects = new_effects
    return deleted
  end
  removeEffect("maraxsis-project-seadragon", "unlock-recipe", "maraxsis-rocket-part")
  removeEffect("rocket-part-productivity", "change-recipe-productivity", "maraxsis-rocket-part")
  data.raw.recipe["rocket-part"].surface_conditions = nil
  data.raw["recipe"]["maraxsis-rocket-part"] = nil
end