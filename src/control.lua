script.on_configuration_changed(function(changed_data)
  local nauvis = game.surfaces.nauvis
  -- Remove biters from nauvis
  if
    settings.startup["hexalith-nuclear-science-peaceful-nauvis"]
    and nauvis ~= nil
    and changed_data ~= nil
    and (changed_data.mod_changes["hexalith-nuclear-science"] ~= nil or changed_data.mod_startup_settings_changed ~= nil)
  then
    for _, entity in pairs(nauvis.find_entities_filtered({force= "enemy"})) do entity.destroy() end
    nauvis.no_enemies_mode = true
  end
end)

-- Change starting evolution on Hexalith to be less hard on easier difficulties

script.on_init(function()
  if game.surfaces["hexalith"] then
    local difficulty = settings.startup["hexalith-nuclear-science-hexalith-difficulty"].value
    if difficulty == "easy" then
      game.forces["enemy"].set_evolution_factor(0.3, game.surfaces.hexalith)
    end
    if difficulty == "baby" then
      game.forces["enemy"].set_evolution_factor(0.0, game.surfaces.hexalith)
    end
  end
end)

script.on_event(defines.events.on_surface_created, function(event)
  local surface = game.surfaces[event.surface_index]
  if surface.name == "hexalith" then
      local difficulty = settings.startup["hexalith-nuclear-science-hexalith-difficulty"].value
      if difficulty == "easy" then
        game.forces["enemy"].set_evolution_factor(0.3, surface)
      end
      if difficulty == "baby" then
        game.forces["enemy"].set_evolution_factor(0.0, surface)
      end
  end
end)