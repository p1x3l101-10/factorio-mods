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