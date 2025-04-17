if settings.startup["hexalith-nuclear-science-natural-gas"].value == "move" then
  -- Remove wellhead to make NG fit in with other fluids
  local NGcfg = settings.startup["adamo-carbon-wellhead"]
  NGcfg.hidden = true
  NGcfg.forced_value = false
end