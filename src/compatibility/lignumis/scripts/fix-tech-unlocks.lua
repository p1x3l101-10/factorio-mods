-- Re-lock lignumis because it looks bad
local FixTechUnlocks = {}

InitNew.on_init = function()
  if game.tick > 0 then return end

  if not game.player.force.technologies["planet-discovery-nauvis"].researched then
    game.player.force.technologies["planet-discovery-lignumis"].researched = false
  end
end

return FixTechUnlocks