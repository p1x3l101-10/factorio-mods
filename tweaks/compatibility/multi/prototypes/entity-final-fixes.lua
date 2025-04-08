if mods["lignumis"] and mods["aai-loaders"] and mods["aai-loaders-electric-powered"] then
  energy_source = nil
end

if mods["crushing-industry"] then
  data.raw["furnace"]["burner-crusher"].next_upgrade = "electric-crusher"
end