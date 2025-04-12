if mods["maraxsis"] and mods["diverse-external-rocket-parts"] then
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
  data.raw["recipe"]["maraxsis-rocket-part"] = nil

  -- New rocket part
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
else