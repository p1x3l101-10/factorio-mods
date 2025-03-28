if mods["wood-military"] and mods["More_Ammo"] then
  local wood_cost = settings.startup["wood-military-ammo-cost"].value
  if settings.startup["wood-military-smg-ammo"].value then
    data.raw["recipe"]["wood-darts-magazine"].ingredients = {{type="item", name="wood", amount=wood_cost}}
  end
end