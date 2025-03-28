if mods["alloy-smelting"] and mods["lignumis"] then
  local tech = data.raw["technology"]["brick-kiln"] 
  tech.prerequisites[#tech.prerequisites + 1] = "planet-discovery-nauvis"
end