-- Re-lock lignumis because it looks bad
local InitNew = {}

InitNew.on_init = function()
  if game.tick > 0 then return end

  if not force.technologies["planet-discovery-nauvis"].researched then
    force.technologies["planet-discovery-lignumis"].researched = false
  end
end

return InitNew