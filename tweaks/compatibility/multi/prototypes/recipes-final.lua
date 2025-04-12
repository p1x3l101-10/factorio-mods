if mods["maraxis"] and mods["diverse-external-rocket-parts"] then
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
else