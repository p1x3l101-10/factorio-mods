if mods["crushing-industry"] then
  data.raw["furnace"]["electric-crusher"].fast_replaceable_group = "electric-crusher"
  data.raw["furnace"]["burner-crusher"].fast_replaceable_group = "electric-crusher"
  data.raw["furnace"]["burner-crusher"].next_upgrade = "electric-crusher"
end