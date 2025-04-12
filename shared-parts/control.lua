local function discover_applied_surfaces()
  local out = {}
  for name, proto in pairs(game.virtual_signal) do
    local surface = name:match("^shared%-lib%-rocketpart%-surface%-(.+)")
    if surface then
    table.insert(out, surface)
    end
  end
  return out
end

script.on_configuration_changed(function()
  if not script.active_mods["diverse-external-rocket-parts"] then return end
  for _, surface in pairs(discover_applied_surfaces()) do
    remote.call("diverse_external_rocket_parts", "add_custom_surface", surface)
  end
end)